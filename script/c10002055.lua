--Stampeding Longhorn
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_TUSKER)
	--creature
	aux.EnableCreatureAttribute(c)
	--cannot be blocked
	aux.EnableCannotBeBlocked(c,aux.CannotBeBlockedLessPowerValue)
end
