--[[
LuCI - Lua Configuration Interface

Copyright 2008 Steven Barth <steven@midlink.org>
Copyright 2008 Jo-Philipp Wich <xm@leipzig.freifunk.net>

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

$Id: uci.lua 3132 2008-09-05 19:27:19Z Cyrus $
]]--

local uci   = require "luci.model.uci".cursor()
local ucis  = require "luci.model.uci".cursor_state()
local table = require "table"


module "luci.jsonrpcbind.uci"
_M, _PACKAGE, _NAME = nil, nil, nil

function add(config, ...)
	uci:load(config)
	local stat = uci:add(config, ...)
	return uci:save(config) and stat
end

function apply(config)
	return uci:apply(config)
end

function changes(...)
	return uci:changes(...)
end

function commit(config)
	return uci:load(config) and uci:commit(config)
end

function delete(config, ...)
	uci:load(config) 
	return uci:delete(config, ...) and uci:save(config) 
end

function delete_all(config, ...)
	uci:load(config)
	return uci:delete_all(config, ...) and uci:save(config) 
end

function foreach(config, stype)
	uci:load(config)
	local sections = {}
	
	return uci:foreach(config, stype, function(section)
		table.insert(sections, section)
	end) and sections
end

function get(config, ...)
	uci:load(config)
	return uci:get(config, ...)
end

function get_all(config, ...)
	uci:load(config)
	local section = ...

	if section then
		return uci:get_all(config, section)
	else
		return uci:get_all(config)
	end
end

function get_state(config, ...)
	ucis:load(config)
	return ucis:get(config, ...)
end

function revert(config)
	return uci:load(config) and uci:revert(config)
end

function section(config, ...)
	uci:load(config)
	return uci:section(config, ...) and uci:save(config)
end

function set(config, ...)
	uci:load(config)
	return uci:set(config, ...) and uci:save(config)
end

function tset(config, ...)
	uci:load(config)
	return uci:tset(config, ...) and uci:save(config)
end

