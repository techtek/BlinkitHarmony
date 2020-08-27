@echo off
cls    
:set   

    :: Set the ONE price
	set /p oneprice=<%~dp0\data\harmonyonepricestriped.txt 

	:: Get the Tasmota device IP from yourtasmotaip.txt 
	set /p ip=<%~dp0\yourtasmotaip.txt
		
	:: Get the Blink length set by the user in yourblinklength.txt 
	set /p blinklength=<%~dp0\yourblinklength.txt
	
	:: Get the set price alert price
	set /p pricealertprice=<%~dp0\yourpricealert.txt
	
	
	:: Colour settings
	set ESC=
	set Red=%ESC%[91m
	set White=%ESC%[37m
	set Green=%ESC%[32m
	set Magenta=%ESC%[35m
	set Blue=%ESC%[94m
    set Grey=%ESC%[90m

  
	SETLOCAL enabledelayedexpansion


  
  
  
  
  
   
:start
cls
   

   
:: Display welcome message to the user welcome.txt      
	type %~dp0\data\welcome.txt

	
:: Let the user know that Blinkit is going to start and watch for new blockchain action with these details:
	echo %Blue%Harmony %Grey%Blink on ONE price above the set alert price%Grey%
	echo.

	  
	  
:: Let the user know additional information	  
	echo %Grey%Coin Gecko price is used
	echo.	

:: Let the user know the selected harmonynode	  
	echo %Grey%The price alert is set at (USD): %pricealertprice%
	echo.		
	

:: Blink the light, by requesting the Tasmota toggle url
	echo %Grey%Testing Tasmota Device Blink... 
    START /MIN CMD.EXE /C %~dp0\TestBlinkTasmota.bat 
	echo.
	
:: Let the user know a sound is being played by displaying the text:
	echo %Grey%Testing Notification Sound...%White%
	
:: Play and test windows notification sound	
	powershell -c echo `a	

:: Let the user know that the program is starting to look for new Blockchain actions
	echo.
	echo %White%Blinkit is now connecting your Tasmota device to the %Blue%Harmony%White% blockchain...	  
	echo.
	
:: Blinkit Script 


::  Download the latest ONE Price and put it inside a txt files
	powershell -Command "Invoke-WebRequest https://cutt.ly/4d2cAbl -OutFile %~dp0\data\harmonyoneprice.txt"
	
:: Find and display the latest Harmony ONE Price in USD from the downloaded txt files	  
	for /F "delims=" %%a in ('findstr /I ""usd"" %~dp0\data\harmonyoneprice.txt') do set "batToolDir0=%%a"

:: Update the ONE price in USD into txt file
	echo %batToolDir0%> %~dp0\data\harmonyonepricestriped.txt

	
:: Deletes unwanted characters from the harmonyonepricestriped.txt and keep only the numeric value
	
	:: Delete characters from harmonyonepricestriped.txt
	FOR /f "delims=" %%i IN (%~dp0\data\harmonyonepricestriped.txt) DO (
	SET line=%%i
	SET line=!line:"=!
	SET line=!line:harmony=!
	SET line=!line:usd=!
	SET line=!line::=!
	SET line=!line:,=!
	SET line=!line:{=!
	SET line=!line:}=!
	SET line=!line:}=!
	echo !line! > %~dp0\data\harmonyonepricestriped.txt
	)
		
	
	
	PING localhost -n 4 >NUL
	

:main   

::  Download the latest ONE Price and put it inside a txt files
	powershell -Command "Invoke-WebRequest https://cutt.ly/4d2cAbl -OutFile %~dp0\data\harmonyoneprice2.txt"
	
:: Find and display the latest Harmony ONE Price in USD from the downloaded txt files	  
	for /F "delims=" %%a in ('findstr /I ""usd"" %~dp0\data\harmonyoneprice2.txt') do set "batToolDir1=%%a"

:: Update the ONE price in USD into txt file
	echo %batToolDir1%> %~dp0\data\harmonyonepricestriped2.txt

	
:: Deletes unwanted characters from the harmonyonepricestriped2.txt and keep only the numeric value
	
	:: Delete characters from harmonyonepricestriped2.txt
	FOR /f "delims=" %%i IN (%~dp0\data\harmonyonepricestriped2.txt) DO (
	SET line=%%i
	SET line=!line:"=!
	SET line=!line:harmony=!
	SET line=!line:usd=!
	SET line=!line::=!
	SET line=!line:,=!
	SET line=!line:{=!
	SET line=!line:}=!
	SET line=!line:}=!
	echo !line! > %~dp0\data\harmonyonepricestriped2.txt
	)
	
	
	PING localhost -n 4 >NUL

    	
:: Compare the 2 downloaded files if different go to "notification", if the files are the same go to "next" 
set /p priceold=<%~dp0\data\harmonyonepricestriped.txt
set /p pricenew=<%~dp0\data\harmonyonepricestriped2.txt


	
	if %pricealertprice% equ %pricenew% goto notification
	if %pricenew% gtr %pricealertprice% goto notification
	goto next	
	
	
	
			
:next
:: let the user know the program is running by displaying the text:  
	echo.
	echo %White%Blinkit is running... %Grey%

	set /p oneprice=<%~dp0\data\harmonyonepricestriped2.txt 
	echo Current ONE Price (USD): %oneprice% 
    
	
	
::  Download the latest ONE Price and put it inside a txt files
	powershell -Command "Invoke-WebRequest https://cutt.ly/4d2cAbl -OutFile %~dp0\data\harmonyoneprice2.txt"
	
:: Find and display the latest Harmony ONE Price in USD from the downloaded txt files	  
	for /F "delims=" %%a in ('findstr /I ""usd"" %~dp0\data\harmonyoneprice2.txt') do set "batToolDir2=%%a"

:: Update the ONE price in USD into txt file
	echo %batToolDir2%> %~dp0\data\harmonyonepricestriped2.txt

	
:: Deletes unwanted characters from the harmonyonepricestriped2.txt and keep only the numeric value

	:: Delete characters from harmonyonepricestriped.txt
	FOR /f "delims=" %%i IN (%~dp0\data\harmonyonepricestriped2.txt) DO (
	SET line=%%i
	SET line=!line:"=!
	SET line=!line:harmony=!
	SET line=!line:usd=!
	SET line=!line::=!
	SET line=!line:,=!
	SET line=!line:{=!
	SET line=!line:}=!
	SET line=!line:}=!
	echo !line! > %~dp0\data\harmonyonepricestriped2.txt
	)
	 
	 :: 8 seconds silent delay (works by pinging local host)
	 PING localhost -n 7 >NUL
	
	goto main

	
    
:notification

:: Let the user know, there is a new action detected by displaying the text:   
	echo.
	echo %White%Blinkit %Blue%Harmony%White% price alert is reached!
	echo %Green%Light blink! %Grey% 

	set /p oneprice=<%~dp0\data\harmonyonepricestriped2.txt 
	echo Current ONE Price (USD): %oneprice% 
   


:: Blink the Tasmota device
    START /MIN CMD.EXE /C %~dp0\TestBlinkTasmota.bat  goto sound

	
	
	:sound
	
:: Play windows notification sound
    powershell  [system.media.systemsounds]::Hand.play()
	


::  Download the latest ONE Price and put it inside a txt files
	powershell -Command "Invoke-WebRequest https://cutt.ly/4d2cAbl -OutFile %~dp0\data\harmonyoneprice.txt"
	
:: Find and display the latest Harmony ONE Price in USD from the downloaded txt files	  
	for /F "delims=" %%a in ('findstr /I ""usd"" %~dp0\data\harmonyoneprice.txt') do set "batToolDir3=%%a"

:: Update the ONE price in USD into txt file
	echo %batToolDir3%> %~dp0\data\harmonyonepricestriped.txt

	
:: Deletes unwanted characters from the harmonyonepricestriped.txt and keep only the numeric value
	
	:: Delete characters from harmonyonepricestriped.txt
	FOR /f "delims=" %%i IN (%~dp0\data\harmonyonepricestriped.txt) DO (
	SET line=%%i
	SET line=!line:"=!
	SET line=!line:harmony=!
	SET line=!line:usd=!
	SET line=!line::=!
	SET line=!line:,=!
	SET line=!line:{=!
	SET line=!line:}=!
	SET line=!line:}=!
	echo !line! > %~dp0\data\harmonyonepricestriped.txt
	)
	 
	 PING localhost -n 5 >NUL

	goto main
	
