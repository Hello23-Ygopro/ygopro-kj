--Quetaro the Gladiator (Alias)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_VOID_SPAWN,RACE_ARMORED_DRAGON)
	aux.AddRaceCategory(c,RACECAT_DRAGON)
	--creature
	aux.EnableCreatureAttribute(c)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--clash (do battle)
	aux.AddSingleTriggerEffect(c,0,EVENT_ATTACK_ANNOUNCE,true,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--clash (do battle)
scard.tg1=aux.ClashTarget(PLAYER_SELF)
function scard.batfilter(c,e)
	return c:IsFaceup() and c:IsCanBeEffectTarget(e)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.Clash(tp) then return end
	local c=e:GetHandler()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectMatchingCard(tp,scard.batfilter,tp,0,LOCATION_BZONE,1,1,nil,e)
	if g:GetCount()==0 or not c:IsFaceup() then return end
	Duel.SetTargetCard(g)
	Duel.DoBattle(c,g:GetFirst())
end
--[[
	Rulings
		Q: If Quetaro attacks a creature and I win the clash, can I have Quetaro battle that creature?
		A: Yes. Your opponent can't block or protect against the battle caused by "Brawl."
		https://kaijudo.fandom.com/wiki/Quetaro_the_Gladiator/Rulings
]]
