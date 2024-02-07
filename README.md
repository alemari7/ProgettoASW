# ASW-PROJECT-23-24
Progetto per il corso di [ASW](http://cabibbo.inf.uniroma3.it/asw/) (Architetture dei sistemi sotware).

Corso erogato nell'anno 2023-2024 dal professore [Luca Cabibbo](https://github.com/lucacabibbo) all'Università Roma Tre.

---

### Linguaggi e Tecnologie utilizzate
<img src="https://skillicons.dev/icons?i=java,gradle,spring,postgres,bash,docker,kafka">

---
## Descrizione

Questo progetto contiene il codice dell'applicazione *OrderManager*, una semplice applicazione a microservizi per gestire ordini di prodotti.

L'applicazione *OrderManager* prevede di:
* creare prodotti e modificare la quantità disponibile (stack level);
* creare ordini relativi a uno o più prodotti;
* richiedere la validazione di un ordine.

Un ordine è considerato valido quando sono verificate queste condizioni:
* esiste;
* esistono tutti i prodotti ordinati;
* le quantità ordinate di ciascun ordine non superano la quantità disponibile.

--- 

L'applicazione *OrderManager* consiste dei seguenti microservizi:

* *product-service*: gestisce i prodotti.
Ogni prodotto ha un nome (con il quale viene identificato), una categoria, un valore di quantità disponibile e un prezzo. 
 
* Operazioni:
  * `POST /products` crea un nuovo prodotto (nome, categoria, quantità disponibile e prezzo, passati nel corpo della richiesta)
  * `GET /products/{name}` trova un prodotto, dato il nome
  * `GET /products` trova tutti i prodotti
  * `POST /findproducts/bynames` trova tutti i prodotti che hanno il nome incluso in una lista di nomi (la lista di nomi è passata nel corpo della richiesta)
  * `PATCH /products` aggiorna la quantità disponibile di un prodotto. 


* *order-service*: gestisce gli ordini.
Ogni ordine ha un id (con il quale viene identificato), un cliente, un indirizzo, un insieme di linee d'ordine (ognuna con nome e quantità del prodotto) e un totale.

* Operazioni:
  * `POST /orders` crea un nuovo ordine (dati del cliente, indirizzo, elementi ordinati e totale, passati nel corpo della richiesta)
  * `GET /orders/{id}` trova un ordine (dato l'id).
  * `GET /orders` trova tutti gli ordini
  * `GET /findorders/customer/{customer}` trova gli ordini di un certo cliente (dato il cliente)
  * `GET /findorders/product/{product}` trova gli ordini contenenti un certo prodotto (dato il prodotto).


* *order-validation-service* permette a un ordine di essere convalidato.
Una validazione dell'ordine consiste di un order-id, alcuni dati dell'ordine (cliente, prodotti ordinati), un indicatore di validità e una motivazione.
* Operazioni:
  * `GET /ordervalidations/{id}` calcola e ritorna la validazione dell'ordine (dato l'id).


* Il servizio *api-gateway* (esposto sulla porta *8080*) è l'application gateway API che:
  * espone *product-service* sul percorso`/product-service` - per esempio, `GET /product-service/products`.
  * espone *order-service* sul percorso `/order-service` - per esempio, `GET /order-service/orders/{id}`
  * espone *order-validation-service* sul percorso `/order-validation-service` - per esempio, `GET /order-validation-service/order-validations/{id}`

---

La cartella shell contiene gli scripts per lanciare e testare l'applicazione.

## Preparing

Oltre a fare il build dell'applicazione e far partire l'esecuzione, è necessario preparare l'applicazione con il comando `docker-compose up`. Così facendo viene avviato Kafka e tutti i vari servizi. 
Una volta che Kafka è avviato, faccio partire la shell *create-kafka-topics.sh* per creare i topic "order" e "product". Inoltre all'avvio dell'applicazione è necessario creare i server su pgAdmin, 
poichè eseguendo `docker-compose up` il database li crea ma non comunicano con pgAdmin. Quindi vanno creati manualmente poichè non è presente uno script che automatizza questo procedimento. 
L'applicazione viene chiusa con il comando `docker-compose down`. Per un secondo riavvio dell'applicazione è necessario solamente il comando `docker-compose up`.

## Build 

Per fare il build dell'applicazione bisogna eseguire il seguente comando:

*  `gradle build`

## Execution

Per lanciare l'applicazione:

* start *Docker* 