with prices AS(SELECT DISTINCT CPG.SalesOrganization,CPG.Material, CPG.CustomerNumber AS "CustomerKey", CASE WHEN CPG.PromotionFlag = 'PromotionFlag' THEN 'true' ELSE 'false' END AS PromotionFlag, CASE WHEN CPG.WebDiscountFlag = 'WebDiscountFlag' THEN 'true' ELSE 'false' END AS WebDiscountFlag,CASE WHEN CPG.QuantityBreakFlag = 'QuantityBreakFlag' THEN'true' ELSE 'false' END AS QuantityBreakFlag,CASE WHEN CPG.ShipAlongFlag = 'ShipAlongFlag' THEN 'true' ELSE 'false' END AS ShipAlongFlagDim,CASE WHEN CPG.EndUserBidsFlag = 'EndUserBidsFlag' THEN 'true' ELSE 'false' END AS EndUserBidsFlag,CPG.PromoEndDt AS PromoEndDt,ShipAlongMaterial,ShipAlongMinQty,ShipAlongFreeQty,CPG.ShipAlongExpireDt,mv.LongDesc1 AS ShipAlongPartDes FROM Catalog.CustomerPriceGroup CPG WITH (NOLOCK) LEFT OUTER JOIN Catalog.vwBasicMaterialAttribute mv ON CPG.SalesOrganization = mv.SalesOrganization AND CPG.ShipAlongMaterial = mv.Material WHERE CPG.SalesOrganization = '3070') SELECT ('MX01' + '@@' + '3070' + '@@' + '10' + '@@' + 'A300'+ '-'+ P.material) AS x_rec_spec,P.material,CustomerKey,PromotionFlag,WebDiscountFlag,cp.QuantityBreakFlag,ShipAlongFlagDim,cp.PromoEndDt,cp.ShipAlongMaterial,cp.ShipAlongMinQty,cp.ShipAlongFreeQty,cp.ShipAlongExpireDt,cp.ShipAlongPartDes FROM catalog.materials P with (nolock) INNER JOIN prices cp ON cp.SalesOrganization = P.SalesOrganization AND cp.material = P.material WHERE P.SalesOrganization = '3070' AND P.WebVisibleFlag = 'WebVisibleFlag' AND  P.DeleteFlag IS NULL Order By P.material