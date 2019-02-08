print('Loaded signal-13 by skrub')

---------------------------------------------------------------------------
-- s13 triggers client event in Signal 13 2 versions so you can do lower or upper case S in the command if your in a panic
---------------------------------------------------------------------------
TriggerEvent('es:addCommand', 's13', function(source, args, user)
	TriggerClientEvent('s13', source, {})
end, {help = "ACTIVATE SIGNAL 13"})

TriggerEvent('es:addCommand', 'S13', function(source, args, user)
	TriggerClientEvent('s13', source, {})
end, {help = "ACTIVATE SIGNAL 13"})
		