with Prod_spec AS(SELECT SalesOrganization, Material, vendorpartNumber,AttributeGroup as HeaderName , AttributeName, AttributeValue,LEFT(LTRIM(RTRIM(AttributeGroup)),255) + '|' + LEFT(LTRIM(RTRIM(AttributeName)),255) + '|' + CAST(LEFT(LTRIM(RTRIM(AttributeValue)),4000) AS NVARCHAR(4000))  AS AttributeDisplay  FROM IMG_DATA.dbo.TBL_Attributes WITH(NOLOCK) WHERE SalesOrganization = '3070')SELECT ('MX01' + '@@' + '3070' + '@@' + '10' + '@@' + 'A300'+ '-'+ P.material) AS x_rec_spec,P.material AS SKU,vendorpartNumber AS VPN,('A300'+'-'+P.Material ) AS globalmaterial, headername,attributename,attributevalue,attributedisplay FROM catalog.materials P with (nolock) INNER JOIN Prod_spec pa ON pa.SalesOrganization = P.SalesOrganization AND pa.material = P.material WHERE P.SalesOrganization = '3070' AND P.WebVisibleFlag = 'WebVisibleFlag' AND P.DeleteFlag IS NULL ORDER BY P.material