--Havoc Sphere
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_VOID_SPAWN,RACE_BATTLE_SPHERE)
	--creature
	aux.EnableCreatureAttribute(c)
	--clash (cast for free)
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,true,aux.ClashTarget(PLAYER_SELF),scard.op1)
end
--clash (cast for free)
function scard.castfilter(c)
	return c:IsSpell() and c:IsManaCostBelow(5)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.Clash(tp) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CASTFREE)
	local g=Duel.SelectMatchingCard(tp,scard.castfilter,tp,LOCATION_HAND,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.CastFree(g)
	end
end
