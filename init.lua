local stairpick = {}

minetest.register_tool("stairpick:stairpick_steel",{
	description = "Pick specifically designed for carving stairs",
	groups = {hard=3,metal=3},
	inventory_image = "stairpick_steel.png",
	stack_max=1,
	liquids_pointable = false,
	
	on_use = function (itemstack, player, pointed_thing)
		return stairpick.use_pick(itemstack,player,pointed_thing)
	end
})

minetest.register_tool("stairpick:stairpick_steel",{
	description = "Pick specifically designed for carving stairs",
	groups = {hard=3,metal=3},
	inventory_image = "stairpick_steel.png",
	stack_max=1,
	liquids_pointable = false,
	
	on_use = function (itemstack, player, pointed_thing)
		return stairpick.use_pick(itemstack,player,pointed_thing)
	end
})

minetest.register_tool("stairpick:stairpick_mese",{
	description = "Pick specifically designed for carving stairs",
	groups = {hard=3,metal=3},
	inventory_image = "stairpick_mese.png",
	stack_max=1,
	liquids_pointable = false,
	
	on_use = function (itemstack, player, pointed_thing)
		return stairpick.use_pick(itemstack,player,pointed_thing)
	end
})

function stairpick.use_pick(itemstack, player, pointed_thing)
		if ( pointed_thing.under == nil )
			return
			
		node = minetest.env:get_node(pointed_thing.under)
		local modname, nodename = string.match(node.name, "([^ ]+):([^ ]+)")
		minetest.log('action',nodename)
		local stairmod = nil
		if ( minetest.registered_nodes["stairs:stair_"..nodename] ~= nil ) then
			stairmod = "stairs"
		elseif ( minetest.registered_nodes["stairsplus:stair_"..nodename] ~= nil ) then
			stairmod = "stairsplus"
		end
		if ( stairmod ~= nil ) then
			-- stairs exist for this node 
			minetest.env:remove_node(pointed_thing.under)
			local fakestack = ItemStack(minetest.registered_nodes[stairmod..":stair_"..nodename])
			minetest.item_place(fakestack, player, pointed_thing)
			if ( itemstack:get_name() == "stairpick:stairpick_steel" ) then
				minetest.log("action","wear on stairpick_steel "..tostring(itemstack:get_wear()))
				itemstack:add_wear(1300)
				minetest.log("action","wear on stairpick_steel "..tostring(itemstack:get_wear()))				
			end
			if ( itemstack:get_name() == "stairpick:stairpick_mese" ) then
				minetest.log("action","wear on stairpick_mese "..tostring(itemstack:get_wear()))
				itemstack:add_wear(900)
				minetest.log("action","wear on stairpick_mese "..tostring(itemstack:get_wear()))
			end
		end
		return itemstack
end


minetest.register_craft({
	output = "stairpick:stairpick_steel",
		
	recipe = {
				{"","default:steel_ingot","default:steel_ingot"},
				{"default:steel_ingot","","default:stick"},
				{"","","default:stick"}
			}
})

minetest.register_craft({
	output = "stairpick:stairpick_mese",
		
	recipe = {
				{"","default:mese_crystal","default:mese_crystal"},
				{"default:mese_crystal","","default:stick"},
				{"","","default:stick"}
			}
})

