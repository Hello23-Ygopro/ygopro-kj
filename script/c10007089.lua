--Freakish Test Subject
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_CYBER_LORD,RACE_CHIMERA)
	--creature
	aux.EnableCreatureAttribute(c)
	--slayer
	aux.EnableSlayer(c)
	--cannot be blocked
	aux.EnableCannotBeBlocked(c)
end
