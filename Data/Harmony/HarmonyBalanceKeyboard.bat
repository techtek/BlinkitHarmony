@echo off
cls    
:set   
	
	:: Get the flashdrive letter set by the user in yourusbdrive.txt
	set /p flashdrive=<%~dp0\yourusbdrive.txt
	
	:: Get the Blink length set by the user in yourblinklength.txt 
	set /p blinklength=<%~dp0\yourblinklength.txt
	
	:: Get the Harmony Wallet address from harmonywallet.txt 
	set /p harmonywallet=<%~dp0\harmonywallet.txt

	:: Get the Harmony node from harmonynode.txt 
	set /p harmonynode=<%~dp0\harmonynode.txt 
    
	:: JSON request body 
    set jsonbody='{\"jsonrpc\":\"2.0\",\"method\":\"hmyv2_getBalance\",\"params\":[\"%harmonywallet%\"],\"id\":1}' 
	
	
	
	:: Colour settings
	set ESC=
	set Red=%ESC%[91m
	set White=%ESC%[37m
	set Green=%ESC%[32m
	set Magenta=%ESC%[35m
	set Blue=%ESC%[94m
    set Grey=%ESC%[90m

  



  
  
  
  
  
   
:start
cls
   
   
:: Display welcome message to the user welcome.txt      
	type %~dp0\data\welcome.txt

	
:: Let the user know that Blinkit is going to start and watch for new blockchain action with these details:
	echo %Blue%Harmony %Grey%Blink on wallet balance changes%Grey%
	echo.
	echo %Grey%Harmony Wallet: %harmonywallet%
    echo.
	  
	
:: Let the user know the selected harmonynode	  
	echo %Grey%Harmony Node %harmonynode%
	echo.	

:: Test blink the lights of the keyboard
	echo %Grey%Testing the keyboards Caps, Scroll, Numlock lights... 	
	START /MIN CMD.EXE /C %~dp0\TestBlinkKeyboard.vbs 
	echo.
	
:: Let the user know a sound is being played by displaying the text:
	echo %Grey%Testing Notification Sound...%White%
	
:: Play and test windows notification sound	
	powershell -c echo `a	

:: Let the user know that the program is starting to look for new Blockchain actions
	echo.
	echo %White%Blinkit is now connecting your keyboard LED lights to the %Blue%Harmony%White% blockchain...	  
	echo.
	
:: Blinkit Script 

:: Download data from the Harmony API and save it into a txt file
	powershell Invoke-RestMethod -ContentType 'application/json' -Method Post -Uri %harmonynode% -Body %jsonbody% -UserAgent "curl" -OutFile  %~dp0\data\downloadeddata.txt"
	powershell -Command "(gc %~dp0\data\downloadeddata.txt) -replace '.$' | Set-Content %~dp0\data\downloadeddata.txt -Force
    powershell -Command "(gc %~dp0\data\downloadeddata.txt) -replace '^.................................' | Set-Content %~dp0\data\downloadeddata.txt -Force
		
	
	
	PING localhost -n 4 >NUL
	

:main   
:: Download data from Harmony API and save it into a txt file
	powershell Invoke-RestMethod -ContentType 'application/json' -Method Post -Uri %harmonynode% -Body %jsonbody% -UserAgent "curl" -OutFile  %~dp0\data\downloadeddata2.txt"
	powershell -Command "(gc %~dp0\data\downloadeddata2.txt) -replace '.$' | Set-Content %~dp0\data\downloadeddata2.txt -Force
    powershell -Command "(gc %~dp0\data\downloadeddata2.txt) -replace '^.................................' | Set-Content %~dp0\data\downloadeddata2.txt -Force
	
	
	
	PING localhost -n 4 >NUL

    	
:: Compare the 2 downloaded files if different go to "notification", if the files are the same go to "next" 
    fc  %~dp0\data\downloadeddata.txt  %~dp0\data\downloadeddata2.txt > nul
	if errorlevel 1 goto notification 
	if errorlevel 0 goto next
		
		
:next
:: let the user know the program is running by displaying the text:  
	echo.
	echo %White%Blinkit is running... %Grey%
	
	:: Display the ONE balance and make the ONE balance readable 	
	set /p coins=<%~dp0\data\downloadeddata2.txt
	powershell -Command "(gc %~dp0\data\downloadeddata2.txt) -replace '..................$' | Set-Content %~dp0\data\downloadeddata2.txt -Force
	set /p wholecoins=<%~dp0\data\downloadeddata2.txt
	echo Available balance (ONE): %wholecoins%.%coins:~-18% 
    
	
	
:: Download data from Harmony API and save it into a txt file
	 powershell Invoke-RestMethod -ContentType 'application/json' -Method Post -Uri %harmonynode% -Body %jsonbody% -UserAgent "curl" -OutFile  %~dp0\data\downloadeddata2.txt"
	 powershell -Command "(gc %~dp0\data\downloadeddata2.txt) -replace '.$' | Set-Content %~dp0\data\downloadeddata2.txt -Force
     powershell -Command "(gc %~dp0\data\downloadeddata2.txt) -replace '^.................................' | Set-Content %~dp0\data\downloadeddata2.txt -Force

	 
	 :: 8 seconds silent delay (works by pinging local host)
	 PING localhost -n 7 >NUL
	
	goto main

	
    
:notification

:: Let the user know, there is a new action detected by displaying the text:   
	echo.
	echo %White%Blinkit new action detected for %Blue%Harmony %White%wallet: 
	echo %Grey%%harmonywallet% 
	echo %Green%Light blink! %White% 
	

:: Blink the keyboards (caps, scroll and Numlock) lights
	set loop=0
	:loop
	START /MIN CMD.EXE /C %~dp0\TestBlinkKeyboard.vbs > nul
	set /a loop=%loop%+1 
	PING localhost -n 7 >NUL
	if "%loop%"=="%blinklength%" goto sound
	goto loop

	
	
	:sound
	
:: Play windows notification sound
    powershell -c echo `a 	
	


:: Download new data from Harmony API and save it into a txt file
	 powershell Invoke-RestMethod -ContentType 'application/json' -Method Post -Uri %harmonynode% -Body %jsonbody% -UserAgent "curl" -OutFile  %~dp0\data\downloadeddata.txt"
	 powershell -Command "(gc %~dp0\data\downloadeddata.txt) -replace '.$' | Set-Content %~dp0\data\downloadeddata.txt -Force
     powershell -Command "(gc %~dp0\data\downloadeddata.txt) -replace '^.................................' | Set-Content %~dp0\data\downloadeddata.txt -Force
	 
	 
	 PING localhost -n 5 >NUL

	goto main