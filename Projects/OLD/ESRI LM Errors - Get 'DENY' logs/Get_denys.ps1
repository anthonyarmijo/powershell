
Select-String -Path "C:\PowerShell\Projects\ESRI LM Errors - Get 'DENY' logs\PCHIAPG009.txt" -Pattern 'TIMESTAMP', 'DENIED' | Select-Object Line | Export-Csv .\Output\US_Central_DENIED.csv -Force

#ForEach-Object { $_ -match "DENIED"} | Where-Object -EQ "True" | Select-String
