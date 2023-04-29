# Importieren der notwendigen Bibliotheken
import pandas as pd
from sklearn.ensemble import RandomForestRegressor
from sklearn.model_selection import train_test_split
from sklearn.metrics import mean_squared_error

# Laden der Daten
data = pd.read_csv('/Users/ogz8fe/Desktop/Code/aktientool/Data.csv')

# Features auswählen
X = data[['beta', 'volAvg', 'mktCap', 'dividendYielTTM', 'peRatioTTM', 'pegRatioTTM', 'payoutRatioTTM', 'currentRatioTTM', 'quickRatioTTM', 'cashRatioTTM', 'daysOfSalesOutstandingTTM', 'daysOfInventoryOutstandingTTM', 'operatingCycleTTM', 'daysOfPayablesOutstandingTTM', 'cashConversionCycleTTM', 'grossProfitMarginTTM', 'operatingProfitMarginTTM', 'pretaxProfitMarginTTM', 'netProfitMarginTTM', 'effectiveTaxRateTTM', 'returnOnAssetsTTM', 'returnOnEquityTTM', 'returnOnCapitalEmployedTTM', 'netIncomePerEBTTTM', 'ebtPerEbitTTM', 'ebitPerRevenueTTM', 'debtRatioTTM', 'debtEquityRatioTTM', 'longTermDebtToCapitalizationTTM', 'totalDebtToCapitalizationTTM', 'interestCoverageTTM', 'cashFlowToDebtRatioTTM', 'companyEquityMultiplierTTM', 'receivablesTurnoverTTM', 'payablesTurnoverTTM', 'inventoryTurnoverTTM', 'fixedAssetTurnoverTTM', 'assetTurnoverTTM', 'operatingCashFlowPerShareTTM', 'freeCashFlowPerShareTTM', 'cashPerShareTTM', 'operatingCashFlowSalesRatioTTM', 'freeCashFlowOperatingCashFlowRatioTTM', 'cashFlowCoverageRatiosTTM', 'shortTermCoverageRatiosTTM', 'capitalExpenditureCoverageRatioTTM', 'dividendPaidAndCapexCoverageRatioTTM', 'priceBookValueRatioTTM', 'priceToBookRatioTTM', 'priceToSalesRatioTTM', 'priceEarningsRatioTTM', 'priceToFreeCashFlowsRatioTTM', 'priceToOperatingCashFlowsRatioTTM', 'priceCashFlowRatioTTM', 'priceEarningsToGrowthRatioTTM', 'priceSalesRatioTTM', 'dividendYieldTTM', 'enterpriseValueMultipleTTM', 'priceFairValueTTM']]

# Label definieren
y = data['performance1y']

# Datensatz in Trainings- und Testdaten aufteilen
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

# Random-Forest-Modell erstellen
rf = RandomForestRegressor(n_estimators=100, random_state=42)

# Modell trainieren
rf.fit(X_train, y_train)

# Vorhersagen für Testdaten machen
y_pred = rf.predict(X_test)

# Root Mean Square Error berechnen
rmse = mean_squared_error(y_test, y_pred)
print("")
print(X_test)
print("")
print(y_pred)
print(rmse)