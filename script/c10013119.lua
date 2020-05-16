--Warchief Kyo
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_BERSERKER)
	--creature
	aux.EnableCreatureAttribute(c)
	--shield blast
	aux.EnableShieldBlast(c)
	--do battle
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,true,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--do battle
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_BZONE) and chkc:IsControler(1-tp) and chkc:IsFaceup() end
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsFaceup,tp,LOCATION_BZONE,0,1,nil)
		and Duel.IsExistingTarget(Card.IsFaceup,tp,0,LOCATION_BZONE,1,nil) end
end
function scard.batfilter(c,e)
	return c:IsFaceup() and c:IsCanBeEffectTarget(e)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g1=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_BZONE,0,nil)
	local g2=Duel.GetMatchingGroup(scard.batfilter,tp,0,LOCATION_BZONE,nil,e)
	if g1:GetCount()==0 or g2:GetCount()==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CREATURE)
	local sg1=g1:Select(tp,1,1,nil)
	Duel.HintSelection(sg1)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local sg2=g2:Select(tp,1,1,nil)
	Duel.SetTargetCard(sg2)
	Duel.DoBattle(sg1:GetFirst(),sg2:GetFirst())
end
