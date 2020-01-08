setlocal EnableDelayedExpansion
cls
::jmeter params

set report_dir=report
set outputfile=testresults.csv
set jmeter_path=C:\Users\gstarczewski\tools\apache-jmeter-5.2.1\bin
set script=pwc_search.jmx
set xmx=-Xmx4g
set xms=-Xms2g
set meta=-XX:MaxMetaspaceSize=256m
::load params
set scenario_params= -Jenvironment=ENV_PWC_AT_OBJECTIVITY ^
			-Jdebug=1 ^
			-Jthreads=20 ^
			-JrampUp=5 ^
			-Jloops=5 ^
			-JtargetThroughput=400 ^
			-JmaxThreadDuration=100

::clean ws

IF EXIST %report_dir% (
    rmdir %report_dir% /s /q
)

IF EXIST %outputfile% (
    del %outputfile%
)

::configure run - memory
set HEAP=%xmx% %xms% %meta%
set run_parameters=-n -t %script% %scenario_params% -l %outputfile% -e -o %report_dir% 


::run
%jmeter_path%\jmeter.bat %run_parameters%
