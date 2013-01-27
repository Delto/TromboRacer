module(..., package.seeall)

function new()
	local o = {}
	
	o.http = require("socket.http")

	o.url = "http://tromboracer.site90.net/connect.php";
	
	function o.getInfo(query)
		--print (o.url .. "?type='getInfo'&query='" .. query .. "'");
		o.body, o.code, o.headers = o.http.request(o.url .. "?type='getInfo'&query=" .. query);
		--print (o.body );
		o.body = string.sub(o.body, 1, -154);
		--print (o.body);
		return o.body;
	end
	
	function o.setInfo(id, enemies, beats)
		--print(query);
		o.body, o.code, o.headers = o.http.request( o.url .. "?type=insert&query=''&id=" .. id .. "&enemies=" .. enemies .. "&beats" .. beats);
		print(o.body);
		return 0;
	end
	
	function o.setGame(id, enemies, beats)
		
		-- o.setInfo("insert+into+races+(user,enemies,beats)values('" .. id .. "','" .. parseArrayToString(enemies) .."','" .. parseArrayToString(beats) .. "')");
		o.setInfo(id,parseArrayToString(enemies), parseArrayToString(beats) );
		
	end
	
	function getGame()
		
		return {{0,0,0,1,2,0,2,1,2,1},{2,1,2,0,2,0,0,1,0,1},{1,0,0,2,2,0,2,1,1,1}}
		
	end
	
	function parseArrayToString(array)
		local strin = "*";
		print(#array);
		for i=1, #array do
			strin = strin .. array[i] .. "*";
		end
		print (strin);
		return strin;
	end
	
	function parseStringToArray(strin) 
		local oldTram = strin;
		local tram = {}
	    local j = 1

		while true do 
				if oldTram:find("*") ~= nil then
				tram[j] = tonumber(oldTram:sub(1, oldTram:find("*")))
				oldTram = oldTram:sub(oldTram:find("*") +1 )
				j = i +1
			else
				break
			end
	    end
	end
	
	return o;
end