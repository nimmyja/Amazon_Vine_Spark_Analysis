SELECT  * FROM (with 
cte1 as(select a.customer_id,customer_count,b.review_id,b.product_id,product_parent,review_date,product_title,star_rating,helpful_votes,total_votes,vine from  customers a,review_id_table b,products c,vine_table d 
where a.customer_id=b.customer_id
and b.product_id= c.product_id
and b.review_id = d.review_id
		 
and total_votes>(select avg(total_votes) from vine_table)
and helpful_votes>(select avg(helpful_votes) from vine_table))
select 'Not Paid' as Program,'Help Ful Votes %' as metric,round((cast(sum(helpful_votes) as decimal )/cast(sum(total_votes) as decimal)) * 100 ,2)  from cte1 where cte1.vine='N'
UNION
select 'Not Paid' as Program,'Help Ful Votes' as metric,sum(helpful_votes) from cte1 where cte1.vine='N'
union
select 'Not Paid' as Program,'No_of_reviews' as metric,count(review_id) from cte1 where cte1.vine='N'
union
select 'Not Paid' as Program,'Avg Rating' as metric,round(avg(star_rating),2) from cte1 where cte1.vine='N'
union
select 'Not Paid' as Program,'5 star rating %' as metric,round((( select count(review_id) from cte1 where cte1.vine='N' and star_rating=5) /cast(count(review_id) as decimal) )* 100 ,2)  from cte1 where cte1.vine='N'
union
select 'Paid' as Program,'Help Ful Votes %' as metric,round((cast(sum(helpful_votes) as decimal )/cast(sum(total_votes) as decimal)) * 100 ,2)  from cte1 where cte1.vine='Y'
union
select 'Paid' as Program,'Help Ful Votes' as metric,sum(helpful_votes) from cte1 where cte1.vine='Y'
union
select 'Paid' as Program,'No_of_reviews' as metric,count(review_id) from cte1 where cte1.vine='Y'
union
select 'Paid' as Program,'Avg Rating' as metric,round(avg(star_rating),2) from cte1 where cte1.vine='Y'
union
select 'Paid' as Program,'5 star rating %' as metric,round((( select count(review_id) from cte1 where cte1.vine='Y' and star_rating=5) /cast(COUNT(review_id) as decimal) )* 100 ,2)  from cte1 where cte1.vine='Y'
) A  order by 1;