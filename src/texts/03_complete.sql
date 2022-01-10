[`
CREATE TABLE "shop_complete" AS
SELECT "uni"."shop"
	,"uni"."p_key"
	,"uni"."itemId"
	,"uni"."itemName"
	,"uni"."itemUrl"
  ,"uni"."slug"
	,"uni"."currentPrice"
	,"uni"."originalPrice"
	,"uni"."officialSale"
  ,"uni"."date"
	,"uni"."itemImage"
  ,"uni"."inStock"
	,"ref"."commonPrice"
  ,"ref"."minPrice"
  ,case when "ref"."minPrice" != '' then "ref"."minPrice" else "ref"."commonPrice" end as "originalPriceHS"
  ,round(("uni"."currentPrice" / nullifzero("originalPriceHS") - 1) * -100, 2)  as "newSale"
FROM "shop_01_unification" "uni"
LEFT JOIN
    (SELECT "itemId"
        , "commonPrice"
        , "minPrice"
        , "date"::varchar as "date"
    FROM "shop_02_refprices") "ref"
ON "uni"."itemId" = "ref"."itemId" AND "uni"."date" = "ref"."date"
;
`]