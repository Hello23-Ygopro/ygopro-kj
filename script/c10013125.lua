--Ardu Totem
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_SPIRIT_TOTEM)
	--creature
	aux.EnableCreatureAttribute(c)
end
