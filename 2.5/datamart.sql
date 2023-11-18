
WITH sales AS
(SELECT TO_CHAR("date", 'YYYY-MM') AS sale_month, shops.product_id, SUM(shops.sales_count) AS sales_fact, SUM(sales_count * products.price)AS income_fact , shop_name
FROM (SELECT *, 'dns' as shop_name FROM shop_dns  
UNION ALL
SELECT *, 'mvideo' as shop_name FROM shop_mvideo  
UNION ALL
SELECT *, 'sitilink' as shop_name FROM shop_sitilink
) as shops INNER JOIN
products ON shops.product_id = products.product_id
GROUP BY sale_month, shops.product_id, shop_name,sales_count,products.price
ORDER BY sale_month, shop_name,product_id),
stats AS 
(SELECT TO_CHAR("plan_date", 'YYYY-MM') AS sale_month,shop_name,plan.product_id, plan_count AS sales_plan, (plan_count * products.price) as income_plan
FROM plan INNER JOIN products ON plan.product_id = products.product_id)
SELECT stats.sale_month,sales.shop_name,sales.product_id,sales_fact,sales_plan,(sales_fact / sales_plan::float)*100|| '%'  as "sF/sP",sales.income_fact, stats.income_plan, (income_fact / income_plan::float)*100 || '%' as "iF/iP"
FROM stats INNER JOIN sales ON stats.sale_month = sales.sale_month AND stats.shop_name=sales.shop_name AND stats.product_id = sales.product_id 
GROUP BY stats.sale_month, sales.shop_name,sales.sales_fact,sales.product_id,stats.sales_plan,sales.income_fact,stats.income_plan
ORDER BY sale_month, shop_name,product_id




--тоько в интернетах почему- то еще вот это упоминают:
--CREATE VIEW view_name AS
--SELECT column1, column2, ...
--FROM table_name
--WHERE condition;

-- куда это засунуть уже непонятно