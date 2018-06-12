function callFunctionWithSleeps(calledFunction, ...) 
	local co = coroutine.create(calledFunction)
	coroutine.resume(co, ...)
end 
  
function sleep(time) 
	local co = coroutine.running() 
	local function resumeThisCoroutine()
		coroutine.resume(co) 
	end 
	setTimer(resumeThisCoroutine, time, 1)
	coroutine.yield()
end 

-----------przykład----------- 
  
--function pauseExample(a, b, c) 
--    outputChatBox("Started the execution. a value: "..tostring(a)) 
--    sleep(5000) 
--    outputChatBox("Waited 5 seconds. b value: "..tostring(b)) 
--    sleep(5000) 
--    outputChatBox("Waited 10 seconds, finishing the execution. c value: "..tostring(c)) 
--end 
  
--callFunctionWithSleeps(pauseExample, 1, 2, 3) 