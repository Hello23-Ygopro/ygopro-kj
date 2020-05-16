--Horrific Tick
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_CHIMERA)
	--creature
	aux.EnableCreatureAttribute(c)
	--blocker
	aux.EnableBlocker(c)
	--guard
	aux.EnableGuard(c)
	--banish
	aux.EnableBattleWinSelfBanish(c,0,scard.con1)
end
--banish
function scard.cfilter(c)
	return c:IsFaceup() and c:IsEvolution()
end
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return not Duel.IsExistingMatchingCard(scard.cfilter,tp,LOCATION_BZONE,0,1,nil)
end
