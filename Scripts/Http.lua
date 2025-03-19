local HTTPSERVICE = {}

local Studio = game["Run Service"]:IsStudio()

local HTTPService = game:GetService("HttpService")
function HTTPSERVICE:Get(URL,Headers)
	if Studio then
		local Return
		local Success,Error = pcall(function()
			Return = HTTPService:GetAsync(URL,Headers)
		end)
		if Error then
			warn(Error)
		end
		return Return
	else
		local Return = loadstring(game:HttpGet(URL))()
		return Return
	end
end
function HTTPSERVICE:Post(URL,Data,ContentType,Headers)
	if Studio then
		local Return
		local Success,Error = pcall(function()
			Return = HTTPService:PostAsync(URL,Data,ContentType,Headers)
		end)
		if Error then
			warn(Error)
		end
		return Return
	else
		warn("Hey ur using the wrong process")
		local Return = loadstring(game:HttpGet(URL))()
		return Return
	end
end

return HTTPSERVICE
