--Oktuska the Infused
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_CYBER_LORD,RACE_BEAST_KIN)
	--creature
	aux.EnableCreatureAttribute(c)
	--draw
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,true,scard.tg1,aux.DrawOperation(PLAYER_SELF,1))
	--to mana zone
	aux.AddSingleTriggerEffect(c,1,EVENT_COME_INTO_PLAY,true,scard.tg2,aux.DecktopSendtoMZoneOperation(PLAYER_SELF,1))
end
--draw
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
end
--to mana zone
function scard.tg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanSendDecktoptoMZone(tp,1) end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
end
--[[
	Rulings
		Q: When Oktuska enters the battlefield, in what order do I use its 2 abilities?
		A: Because the "Ingenuity" and "Mana Tendrils" abilities both trigger at the same time, you can use those
		abilities in either order.
		https://kaijudo.fandom.com/wiki/Oktuska_the_Infused/Rulings
]]
