--Scaradorable of Gloom Hollow
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_CHIMERA)
	aux.AddNameCategory(c,NAMECAT_SCARADORABLE)
	--creature
	aux.EnableCreatureAttribute(c)
	--blocker
	aux.EnableBlocker(c)
	--cannot be banished
	aux.EnableCannotBeBanished(c,LOCATION_BZONE,LOCATION_BZONE,scard.tg1)
end
--cannot be banished
function scard.tg1(e,c)
	local tc=e:GetHandler():GetBattleTarget()
	return e:GetHandler() and tc and tc:IsManaCostBelow(4)
end
