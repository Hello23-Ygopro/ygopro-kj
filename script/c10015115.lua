--Rygar the Tank
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_BERSERKER)
	--creature
	aux.EnableCreatureAttribute(c)
	--do battle
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,true,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET,scard.con1)
	--discard, draw
	aux.AddSingleTriggerEffectWinBattle(c,1,true,scard.tg2,scard.op2)
end
--do battle
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)==0
end
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,Card.IsFaceup,0,LOCATION_BZONE,1,1,HINTMSG_TARGET)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsFaceup() and tc and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.DoBattle(c,tc)
	end
end
--discard, draw
function scard.tg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(aux.TRUE,tp,LOCATION_HAND,0,1,nil)
		or Duel.IsPlayerCanDraw(tp,1) end
end
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
	Duel.KJSendtoDPile(g,REASON_EFFECT+REASON_DISCARD)
	Duel.Draw(tp,2,REASON_EFFECT)
end
--[[
	Rulings
	Q: If I have no cards in my hand when I use "Brazen Tactics," can I draw 2 cards?
		A: Yes. Even if you have no cards in your hand, you can still choose to discard your hand.
	https://kaijudo.fandom.com/wiki/Rygar_the_Tank/Rulings
]]
