--Lamp-Lighter
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_MECHA_THUNDER,RACE_DREAD_MASK)
	--creature
	aux.EnableCreatureAttribute(c)
end
