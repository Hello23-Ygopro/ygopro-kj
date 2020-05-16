--Sandstorm Prowler
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_DUNE_GECKO)
	--creature
	aux.EnableCreatureAttribute(c)
	--attack untapped
	aux.EnableAttackUntapped(c)
	--cannot be attacked
	aux.EnableCannotBeAttacked(c,nil,scard.con1)
end
--cannot be attacked
function scard.cfilter(c)
	return c:IsFaceup() and c:IsTapped()
end
function scard.con1(e)
	return Duel.IsExistingMatchingCard(scard.cfilter,e:GetHandlerPlayer(),LOCATION_BZONE,0,1,e:GetHandler())
end
