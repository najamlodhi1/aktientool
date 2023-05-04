import pandas as pd
import requests
import json
import time
time.time()

timestamp1 = time.time()

try:
        
    response=requests.get("https://api.exchangerate.host/latest?base=USD")
    if response.status_code == 200:
        rates=response.json()["rates"]
    else:
        raise Exception(f"Error :( status_code={response.status_code}")

    masterList = []

    response = requests.get("https://financialmodelingprep.com/api/v3/financial-statement-symbol-lists?apikey=9ad9c8dfa54c11aff6c1489d109e87b6")
    print(response)

    if response.status_code == 200:
        
        #allSymbols = response.json()
        allSymbols = ["GOOG","AAPL"] #Zum testen

        new_string = ','.join(allSymbols)
        print("")
        print(new_string)
        print("")



        Count = 1
        for Symbol in allSymbols:

            if Symbol == "" or "\n" in Symbol or " " in Symbol:
                
                continue
            
            else:
 
                response = requests.get(f"https://financialmodelingprep.com/api/v4/company-outlook?symbol={Symbol}&apikey=9ad9c8dfa54c11aff6c1489d109e87b6")

                if response.status_code == 200:
                
                    Data = response.json()

                    try:
                        symbol                                = Data["profile"]["symbol"]
                    except:
                        symbol                                = Symbol

                    try:
                        price                                 = Data["profile"]["price"]
                    except:
                        price                                 = 0

                    try:
                        beta                                  = Data["profile"]["beta"]
                    except:
                        beta                                  = ""

                    try:
                        volAvg                                = Data["profile"]["volAvg"]
                    except:
                        volAvg                                = 0

                    try:
                        mktCap                                = Data["profile"]["mktCap"]
                    except:
                        mktCap                                = 0

                    try:
                        changes                               = Data["profile"]["changes"]
                    except:
                        changes                               = ""

                    try:
                        companyName                           = Data["profile"]["companyName"]
                    except:
                        companyName                           = ""

                    try:
                        currency                              = Data["profile"]["currency"]
                    except:
                        currency                              = ""

                    try:
                        exchangeShortName                     = Data["profile"]["exchangeShortName"]
                    except:
                        exchangeShortName                     = ""

                    try:
                        industry                              = Data["profile"]["industry"]
                    except:
                        industry                              = ""

                    try:
                        sector                                = Data["profile"]["sector"]
                    except:
                        sector                                = ""

                    try:
                        country                               = Data["profile"]["country"]
                    except:
                        country                               = ""

                    try:
                        fullTimeEmployees                     = Data["profile"]["fullTimeEmployees"]
                    except:
                        fullTimeEmployees                     = ""

                    try:
                        image                                 = Data["profile"]["image"]
                    except:
                        image                                 = ""

                    try:
                        isEtf                                 = Data["profile"]["isEtf"]
                    except:
                        isEtf                                 = ""

                    try:
                        isFund                                = Data["profile"]["isFund"]
                    except:
                        isFund                                = ""

                    try:
                        ratios                                = Data["ratios"][0]
                    except:
                        ratios                                = ""

                    
                    try:
                        ratingRecommendation              = Data["rating"][0]["ratingRecommendation"]
                    except:
                        ratingRecommendation              = ""

                    try:
                        ratingDetailsDCFRecommendation    = Data["rating"][0]["ratingDetailsDCFRecommendation"]
                    except:
                        ratingDetailsDCFRecommendation    = ""
                    try:
                        ratingDetailsROERecommendation    = Data["rating"][0]["ratingDetailsROERecommendation"]
                    except:
                        ratingDetailsROERecommendation    = ""
                    try:
                        ratingDetailsROARecommendation    = Data["rating"][0]["ratingDetailsROARecommendation"]
                    except:
                        ratingDetailsROARecommendation    = ""
                    try:
                        ratingDetailsDERecommendation     = Data["rating"][0]["ratingDetailsDERecommendation"]
                    except:
                        ratingDetailsDERecommendation     = ""
                    try:
                        ratingDetailsPERecommendation     = Data["rating"][0]["ratingDetailsPERecommendation"]
                    except:
                        ratingDetailsPERecommendation     = ""
                    try:
                        ratingDetailsPBRecommendation     = Data["rating"][0]["ratingDetailsPBRecommendation"]
                    except:
                        ratingDetailsPBRecommendation     = ""
                    
                    try:
                        eps                               = Data["financialsAnnual"]["income"][0]["eps"]
                    except: 
                        eps                               = 0

                    try:

                        response1y = requests.get(f"https://financialmodelingprep.com/api/v3/stock-price-change/{Symbol}?apikey=9ad9c8dfa54c11aff6c1489d109e87b6")
                        year = response1y.json()

                        performance1y                     = year[0]["1Y"]
                    except: 
                        performance1y                     = 0

                    if isEtf == True or price == None or price == 0 or country == None or country == "" or changes == None or changes == "" or mktCap == 0 or mktCap == None or volAvg == 0 or volAvg == None:
                        continue


                    try:
                        
                        if currency == "ILA":
                            
                            mktCap                        = mktCap / 395.56
                            currency                      = "USD"
                        
                        elif currency != "USD" and  currency != "" and currency != None and currency != "None":
                            
                            mktCap                        = mktCap / rates[currency.upper()]
                            currency                      = "USD"
                    
                    except Exception as E:
                        continue

                    
                    Object = {

                        "symbol":symbol,
                        "price":price,
                        "beta":beta,
                        "volAvg":volAvg,
                        "mktCap":mktCap,
                        "changes":changes,
                        "companyName":companyName,
                        "currency":currency,
                        "exchangeShortName":exchangeShortName,
                        "industry":industry,
                        "sector":sector,
                        "country":country,
                        "fullTimeEmployees":fullTimeEmployees,
                        "image":image,
                        "isEtf":isEtf,
                        "isFund":isFund,
                    }

                    Object.update(ratios)

                    Object.update({
                        "ratingRecommendation":ratingRecommendation,
                        "ratingDetailsDCFRecommendation":ratingDetailsDCFRecommendation,
                        "ratingDetailsROERecommendation":ratingDetailsROERecommendation,
                        "ratingDetailsROARecommendation":ratingDetailsROARecommendation,
                        "ratingDetailsDERecommendation":ratingDetailsDERecommendation,
                        "ratingDetailsPERecommendation":ratingDetailsPERecommendation,
                        "ratingDetailsPBRecommendation":ratingDetailsPBRecommendation,
                        "eps":eps,
                        "performance1y":performance1y,
                    })
                    
                    masterList.append(Object)
                    print(f"{Count}) {Symbol}")
                    Count+=1


                elif response.status_code == 500:
                    continue
                
                else:

                    print(f"Error :(  status_code={response.status_code}")
                    break

    else:

        print(f"Error :(  status_code={response.status_code}")


except KeyboardInterrupt:
    print("Program Exited ...")
except Exception as E:
    print("Error :(",E)
else:
    print("Done :)")        
finally:
    df = pd.DataFrame(masterList)
    print(f"Total rows : {df.shape[0]}")

    if df.shape[0] > 0:

        print("Removing duplicate rows on with respect to companyName's with lowest volume ...")
        df = df.sort_values(by='volAvg',ascending=False).drop_duplicates('companyName', keep='first')
        print(f"Total rows left : {df.shape[0]}")

        print("Removing rows where isEtf == True or isFund == True  ...")
        df = df.loc[(df['isEtf'] != True) | (df['isFund'] != True)]
        print(f"Total rows left : {df.shape[0]}")

        df.to_csv("Data.csv",index=False)
        
        with open("Data.json","w") as W:
            W.write(json.dumps(df.to_dict(orient='records'),indent=3))
        

    print("Execution Finished :)")
timestamp2 = time.time()
print ("This took %.2f seconds" % (timestamp2 - timestamp1))
print ("This took %.2f minutes" % ((timestamp2 - timestamp1)/60))
print ("This took %.2f hours  " % ((timestamp2 - timestamp1)/3600))