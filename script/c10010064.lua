--Crystal Pulse
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--shield blast
	aux.EnableShieldBlast(c)
	--confirm deck (cast for free or to mana zone)
	aux.AddSpellCastEffect(c,0,nil,scard.op1)
end
--confirm deck (cast for free or to mana zone)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)==0 then return end
	Duel.ConfirmDecktop(tp,1)
	local tc=Duel.GetDecktopGroup(tp,1):GetFirst()
	Duel.DisableShuffleCheck()
	if tc:IsSpell() and tc:IsHasEffect(EFFECT_SHIELD_BLAST) then
		Duel.CastFree(tc)
	else
		Duel.SendtoMZone(tc,POS_FACEUP_UNTAPPED,REASON_EFFECT)
	end
end
