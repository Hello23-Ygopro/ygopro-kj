--Fight!
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--shield blast
	aux.EnableShieldBlast(c)
	--do battle
	aux.AddSpellCastEffect(c,0,nil,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--do battle
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
--[[
	Rulings
		Q: Say my chosen creature has an ability that triggers whenever it attacks, or my opponent's creature has an
		ability that says it can't be attacked. Do those abilities apply?
		A: No. Your creature isn't attacking. However, any abilities that refer to battling or that trigger whenever
		a creature wins or loses a battle will apply.

		Q: Can my opponent block my creature?
		A: No. Fight! doesn't make your creature attack, so it can't be blocked.

		Q: If my opponent doesn't have any creatures in the battle zone, can I cast Fight! and have my creature break any
		of my opponent's shields?
		A: No. If either you or your opponent doesn't have any creatures in the battle zone, Fight! won't do anything.
		https://kaijudo.fandom.com/wiki/Fight!/Rulings
]]
