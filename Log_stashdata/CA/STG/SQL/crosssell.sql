with cross_sell AS(select distinct SalesOrganization,material ,vendorpartNumber ,AdditionalMaterial, ContentType, OrderNumber from IMG_DATA.dbo.TBL_CrossSell_FT with (nolock) where  (ContentType='Warranty' or ServiceType='C' )) SELECT ('CA01' + '@@' + '8030' + '@@' + '10' + '@@' + 'A300'+ '-'+ P.Material) AS "X_REC_SPEC",P.material AS SKU,vendorpartNumber AS VPN,AdditionalMaterial,ContentType,OrderNumber FROM catalog.materials P with (nolock) INNER JOIN cross_sell cs ON cs.SalesOrganization = P.SalesOrganization AND cs.material = P.material WHERE P.SalesOrganization = '8030' AND P.WebVisibleFlag = 'WebVisibleFlag' AND P.DeleteFlag IS NULL order by cs.Material,OrderNumber,AdditionalMaterial
