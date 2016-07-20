LPARAMETERS lndelay
DECLARE Sleep IN kernel32 INTEGER dwMilliseconds
dwMilliseconds = lndelay*1000
Sleep(dwMilliseconds)
CLEAR DLLS Sleep