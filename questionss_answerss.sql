/*Q.1 The company would like to know which of its products is the most popular among customers. You figure that 
the average rating given in reviews is correlated with the number of sales of a particular product 
(that products with higher reviews have more sales).*/

select product.productId, product.name, avg(productreview.rating) as avgrating,count(productreview.productreviewid) as num_rating 
from product inner join productreview on product.productid = productreview.productid
group by product.NAME
order by productreview.rating DESC
;

/*Q.2.1*/
select pm.productmodelid,pd.description
from productModelProductDescriptionCulture as pm INNER join productDescription as pd on pm.productdescriptionid = pd.productdescriptionid
where cultureid like 'en';

/*Q.2.2 Now that we got the productModelID and its description. We can use the result in Exercise 2.1 
to further expand our query to find out its name, and the quantity it sold.*/
with english_description as(
select pm.productmodelid,pd.description, pm.cultureid
from productModelProductDescriptionCulture as pm 
 INNER join productDescription as pd on pm.productdescriptionid = pd.productdescriptionid where cultureid like 'en'
)
select english_description.productmodelid,english_description.description,product.name, sum(salesorderdetail.orderqty) as total_order
from english_description inner join product on english_description.productmodelid = product.productmodelid
inner join salesorderdetail on salesorderdetail.productid = product.productid
group by product.NAME 
order by total_order desc;

/*Q.3.1*/
select productid, sum(orderqty) as quantity from salesorderdetail
group by 1;

/*Q.3.2*/
select product.productid, productcategory.name as category, productsubcategory.name as subcategory, product.listprice
from product inner join productsubcategory on product.productsubcategoryid = productsubcategory.productsubcategoryid
inner join productcategory on productcategory.productcategoryid = productsubcategory.productcategoryid;

/*Q.3.3 Now that we have the productID and its quantity sold from Exercise 3.1, as well as the category, subcategory, 
and list price from Exericse 3.2. We can now merge the two solutions together to obtain a table showing the average list price
and the total quantity of products sold for each subcategory.*/
with product_quantities as (
select productid, sum(orderqty) as quantity from salesorderdetail
group by 1),
product_prices as (
select product.productid, productcategory.name as category, productsubcategory.name as subcategory, product.listprice
from product inner join productsubcategory on product.productsubcategoryid = productsubcategory.productsubcategoryid
inner join productcategory on productcategory.productcategoryid = productsubcategory.productcategoryid)

select product_prices.category, product_prices.subcategory, avg(product_prices.listprice) as average_price_in_subcategory,
sum(product_quantities.quantity) as total_items_sold_in_subcategory  from 
product_quantities inner join product_prices on product_quantities.productid = product_prices.productid
group by 1,2;

/*Q.4.1 Let’s start by finding our top five performing salespeople by using the salesytd (Sales, year-to-date) column.*/
select businessentityid, salesytd from salesperson
order by salesytd DESC
limit 5;

/*Q.5.1*/
select salespersonid,sum(subtotal) as total_sales from salesorderheader
where salespersonid is not null and salespersonid <> ''
and orderdate >= '2014-01-01'
group by 1
order by 2 desc
limit 5
;

/*Q6.1 Write a query that shows the total amount of money paid by their salesOrderID (this column in the salesOrderDetail table).*/
select salesorderid,sum(orderqty*unitprice) as ordertotal from salesorderdetail
group by 1;

/*Q 6.2 Using 5.1 and 6.1 find the sales for each salesperson for the year 2014 and display results for the top 5 salespeople.*/
with salesPersonsAndOrder as (
select salespersonid,sum(subtotal) as total_sales,salesorderid from salesorderheader
where salespersonid is not null and salespersonid <> ''
and orderdate >= '2014-01-01'
group by 1
order by 2 desc
limit 5
),
orders as (
select salesorderid,sum(orderqty*unitprice) as ordertotal from salesorderdetail
group by 1)

select salesPersonsAndOrder.salespersonid,salesPersonsAndOrder.total_sales as ordertotalsum
from salesPersonsAndOrder inner join orders on salesPersonsAndOrder.salesorderid = orders.salesorderid
;

/*Q.7 see whether there is a positive relationship between the total sales of the salespeople and their commission percentages.*/
with salesPersonsTotalSales as (
    with salesPersonsAndOrder as (
	select salespersonid,sum(subtotal) as total_sales,salesorderid from salesorderheader
	where salespersonid is not null and salespersonid <> ''
	and orderdate >= '2014-01-01'
	group by 1
	order by 2 desc

	),
	orders as (
	select salesorderid,sum(orderqty*unitprice) as ordertotal from salesorderdetail
	group by 1)

	select salesPersonsAndOrder.salespersonid,salesPersonsAndOrder.total_sales as ordertotalsum
	from salesPersonsAndOrder inner join orders on salesPersonsAndOrder.salesorderid = orders.salesorderid
)
select salesPersonsTotalSales.salespersonid,salesPersonsTotalSales.ordertotalsum,salesperson.commissionpct
from salesPersonsTotalSales inner join salesperson on salesPersonsTotalSales.salespersonid = salesperson.businessentityid 
order by 1;

/*Q8.1 */
select s.salespersonid,s.salesorderid,
	case when c.currencyrateid is null then 'NONE' else c.currencyrateid end as currencyrateid,
    case when c.tocurrencycode is null then 'NONE' else c.tocurrencycode end as tocurrencycode
from salesorderheader s left join currencyrate c on s.currencyrateid = c.currencyrateid
where s.salespersonid is NOT NULL and s.salespersonid <> ''
and orderdate >= '2014-01-01'
order by 1;

select * from currencyrate;
/*Q8.2 The None in the above query can be confusing to someone who doesn’t understand the database.
In this case, it’s best to replace them with useful information.*/
select s.salespersonid,s.salesorderid,
    case when c.tocurrencycode is null then 'USD' else c.tocurrencycode end as tocurrencycode
from salesorderheader s left join currencyrate c on s.currencyrateid = c.currencyrateid 
where s.salespersonid is NOT NULL and s.salespersonid <> ''
and orderdate >= '2014-01-01'
order by 1;

/*Q.9 Now that we have the currency codes associated with each salesperson ID, redo Exercise 7, adding in the toCurrencyCode. 
Order the results by currency (ascending) and total sales (descending) to make it easier to see who the best salespeople are for
each currency*/
with salesPersonTotalSales as (
	with salesPersonsAndOrder as (
	select salespersonid,sum(subtotal) as total_sales,salesorderid,currencyrate.toCurrencyCode from salesorderheader
  	 left join currencyrate currencyrate on salesorderheader.currencyrateid = currencyrate.currencyrateid
	where salespersonid is not null and salespersonid <> ''
	and orderdate >= '2014-01-01'
	group by 1
	order by 2 desc
	),
	orders as (
	select salesorderid,sum(orderqty*unitprice) as ordertotal from salesorderdetail
	group by 1)

	select salesPersonsAndOrder.salespersonid,salesPersonsAndOrder.total_sales as ordertotalsum, 
		case when salesPersonsAndOrder.toCurrencyCode is NULL then 'USD' ELSE salesPersonsAndOrder.toCurrencyCode END as toCurrencyCode
	from salesPersonsAndOrder inner join orders on salesPersonsAndOrder.salesorderid = orders.salesorderid
)
select s.salespersonid, s.tocurrencycode,s.ordertotalsum,salesperson.commissionpct
from salesPersonTotalSales s inner join salesperson on s.salespersonid = salesperson.businessentityid
order by 2
;


