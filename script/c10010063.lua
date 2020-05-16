--Bronze-Arm Renegade
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_CORRUPTED,RACE_BEAST_KIN)
	--creature
	aux.EnableCreatureAttribute(c)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--banish replace (to mana zone)
	aux.AddReplaceEffectBanish(c,0,scard.tg1,scard.op1,scard.val1)
end
--banish replace (to mana zone)
function scard.repfilter(c,tp)
	return c:IsLocation(LOCATION_BZONE) and c:IsFaceup() and c:KJIsRace(RACE_CORRUPTED)
		and c:IsControler(tp) and not c:IsReason(REASON_REPLACE) and c:IsAbleToMZone()
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return eg:IsExists(scard.repfilter,1,nil,tp) end
	local g=eg:Filter(scard.repfilter,nil,tp)
	g:KeepAlive()
	e:SetLabelObject(g)
	return true
end
function scard.val1(e,c)
	return scard.repfilter(c,e:GetHandlerPlayer())
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,sid)
	Duel.SendtoMZone(e:GetLabelObject(),POS_FACEUP_UNTAPPED,REASON_EFFECT+REASON_REPLACE)
end
--[[
	Rulings
		Q: If Bronze-Arm Renegade and another Corrupted creature are banished at the same time, can I put them both into
		my mana zone?
		A: Yes. "Mana Extraction" will apply to any Corrupted creature banished at the same time as Bronze-Arm Renegade.

		Q: Say I summon Ripper Reaper and use its "Cursed Scythe" ability. I choose to banish my Bronze-Arm Renegade and
		use "Mana Extraction" to put it into my mana zone. Will my opponent still have to choose one of his or her
		creatures to be banished?
		A: Yes. Some abilities like "Cursed Scythe" say that you may do something and "if you do," there's an additional
		effect. These abilities consider only if you chose to take the action, even if the final result of that action
		changes because of replacement effects. Since you chose to banish Bronze-Arm Renegade, the additional effect of
		the "Cursed Scythe" ability will happen.
		https://kaijudo.fandom.com/wiki/Bronze-Arm_Renegade/Rulings
]]
