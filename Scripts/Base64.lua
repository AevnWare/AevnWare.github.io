local Base64Module = {}

-- Base64 encode function
function Base64Module.encode(input)
	local b64_chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
	local output = {}
	local padding = ""

	-- Make sure the input is a multiple of 3 characters
	local padding_count = #input % 3
	if padding_count > 0 then
		padding = string.rep("=", 3 - padding_count)
		input = input .. string.rep("\0", 3 - padding_count)
	end

	-- Encode the input in chunks of 3 bytes
	for i = 1, #input, 3 do
		local chunk = string.sub(input, i, i + 2)
		local byte1, byte2, byte3 = string.byte(chunk, 1, 3)

		local index1 = math.floor(byte1 / 4)
		local index2 = ((byte1 % 4) * 16) + math.floor(byte2 / 16)
		local index3 = ((byte2 % 16) * 4) + math.floor(byte3 / 64)
		local index4 = byte3 % 64

		table.insert(output, b64_chars:sub(index1 + 1, index1 + 1))
		table.insert(output, b64_chars:sub(index2 + 1, index2 + 1))
		table.insert(output, b64_chars:sub(index3 + 1, index3 + 1))
		table.insert(output, b64_chars:sub(index4 + 1, index4 + 1))
	end

	-- Add padding if needed
	for i = 1, #padding do
		output[#output - i + 1] = "="
	end

	return table.concat(output)
end

-- Base64 decode function
function Base64Module.decode(input)
	local b64_chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
	local output = {}
	local padding_count = 0

	-- Count padding
	if input:sub(-1) == "=" then
		padding_count = 1
		if input:sub(-2, -2) == "=" then
			padding_count = 2
		end
	end

	-- Remove padding and decode the Base64 string
	input = input:gsub("=", "")

	for i = 1, #input, 4 do
		local chunk = string.sub(input, i, i + 3)
		local byte1 = b64_chars:find(chunk:sub(1, 1)) - 1
		local byte2 = b64_chars:find(chunk:sub(2, 2)) - 1
		local byte3 = b64_chars:find(chunk:sub(3, 3)) - 1
		local byte4 = b64_chars:find(chunk:sub(4, 4)) - 1

		table.insert(output, string.char(bit32.lshift(byte1, 2) + bit32.rshift(byte2, 4)))
		if byte3 ~= -1 then
			table.insert(output, string.char(bit32.lshift(byte2, 4) + bit32.rshift(byte3, 2)))
		end
		if byte4 ~= -1 then
			table.insert(output, string.char(bit32.lshift(byte3, 6) + byte4))
		end
	end

	-- Remove padding from output if necessary
	if padding_count > 0 then
		return table.concat(output):sub(1, -padding_count - 1)
	else
		return table.concat(output)
	end
end

return Base64Module
