--King Neptas
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_LEVIATHAN)
	--creature
	aux.EnableCreatureAttribute(c)
	--cannot be targeted
	aux.EnableCannotBeTargeted(c)
end
