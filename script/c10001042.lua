--Rumbling Terrasaur
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_TUSKER)
	--creature
	aux.EnableCreatureAttribute(c)
end
