--Bagash
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_STOMPER)
	--creature
	aux.EnableCreatureAttribute(c)
	--cannot be attacked
	aux.EnableCannotBeAttacked(c,nil,scard.con1)
	aux.AddEffectDescription(c,0,scard.con1)
end
--cannot be attacked
function scard.con1(e)
	return Duel.IsExistingMatchingCard(Card.IsFaceup,e:GetHandlerPlayer(),LOCATION_BZONE,0,1,e:GetHandler())
end
