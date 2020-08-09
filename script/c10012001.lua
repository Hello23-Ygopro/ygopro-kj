--Arcane Warden
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_SKYFORCE_CHAMPION)
	--creature
	aux.EnableCreatureAttribute(c)
	--blocker
	aux.EnableBlocker(c)
	--skirmisher
	aux.EnableSkirmisher(c)
	--confirm deck (to hand)
	aux.AddSingleTriggerEffect(c,0,EVENT_CUSTOM+EVENT_BLOCK,true,aux.CheckDeckFunction(PLAYER_SELF),scard.op1)
end
--confirm deck (to hand)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)==0 then return end
	Duel.ConfirmDecktop(tp,1)
	local tc=Duel.GetDecktopGroup(tp,1):GetFirst()
	if tc:IsSpell() and tc:IsAbleToHand() then
		Duel.DisableShuffleCheck()
		Duel.SendtoHand(tc,PLAYER_OWNER,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,tc)
		Duel.ShuffleHand(tp)
	else
		Duel.MoveSequence(tc,SEQ_DECK_BOTTOM)
	end
end
--[[
	References
	* Gishki Diviner
	https://github.com/Fluorohydride/ygopro-scripts/blob/2bfd0c7/c72403299.lua#L23
]]
