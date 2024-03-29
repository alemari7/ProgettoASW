#!/bin/bash

# trova e valida un ordine 

if [ $# -eq 0 ]
  then
    echo "Manca il parametro: orderId"
	exit 1 
fi

ORDERID=$1 

echo "# trova l'ordine $ORDERID" 
echo $(curl -s localhost:8080/order-service/orders/${ORDERID}) | json_pp
echo 

echo "# convalida l'ordine $ORDERID" 
echo $(curl -s localhost:8080/order-validation-service/ordervalidations/${ORDERID}) | json_pp
echo 


