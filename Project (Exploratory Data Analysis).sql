-- EXPLORATORY DATA ANALYSIS--

SELECT *
FROM world_layoffs.layoffs_staging2;

select max(total_laid_off), max(percentage_laid_off)
from layoffs_staging2
;
select *
from layoffs_staging2
where percentage_laid_off = 1
order by total_laid_off desc
;

select company, sum(total_laid_off)
from layoffs_staging2
group by company
order by 2 desc;

select min(`date`), max(`date`)
from layoffs_staging2
;
select country, sum(total_laid_off)
from layoffs_staging2
group by country
order by 2 desc;

select*
from layoffs_staging2;

select year(`date`), sum(total_laid_off)
from layoffs_staging2
group by year(`date`)
order by 2 desc;
;
select stage, sum(total_laid_off)
from layoffs_staging2
group by stage
order by 2 desc;

select company, avg(percentage_laid_off)
from layoffs_staging2
group by company
order by 2 desc;

select substring(`date`,1,7) as `MONTH`, sum(total_laid_off)
from layoffs_staging2
where substring(`date`,1,7) is not null
group by `MONTH`
order by 1 asc
;
with Rolling_Total as 
(select substring(`date`,1,7) as `MONTH`, sum(total_laid_off) as total_off
from layoffs_staging2
where substring(`date`,1,7) is not null
group by `MONTH`
order by 1 asc
)
select `MONTH`, total_off,
sum(total_off)  over(order by `MONTH`) as rolling_total
FROM Rolling_Total;

select company, sum(total_laid_off)
from layoffs_staging2
group by company
order by 2 desc;

select company, Year(`date`), sum(total_laid_off)
from layoffs_staging2
group by company, Year(`date`)
order by 3 desc;

with Company_Year (company, years, total_laid_off) as
(
select company, Year(`date`), sum(total_laid_off)
from layoffs_staging2
group by company, Year(`date`)
), Company_Year_Rank as
(select *, dense_rank() over(partition by years order by total_laid_off desc) as Ranking
from Company_Year
where years is not null
)
select* 
from Company_Year_Rank
where Ranking <= 5;





























