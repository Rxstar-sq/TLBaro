Hook.Add("character.applyDamage", "LuaArmor.ApplyDamage", function (characterHealth, attackResult, hitLimb)
    if hitLimb.type ~= LimbType.Torso then return end

    local character = characterHealth.Character
    if character.Inventory == nil then return end
    local armor = character.Inventory.GetItemInLimbSlot(InvSlotType.OuterClothes)

    if armor == nil or armor.Prefab.Identifier ~= "luaarmor" then return end

    local damage = 0

    for aaaaa in attackResult.Afflictions do
        damage = damage + aaaaa.Strength
    end

    armor.Condition = armor.Condition - damage*0.1

    print(armor.Condition)

    if armor.Condition > 0 then
        return true
    else
        Entity.Spawner.AddEntityToRemoveQueue(armor)
    end
end)

Hook.Add("examples.givemoney", "examples.givemoney", function ()
 local MoneyAmount = 50000;
 local character
    if SERVER then
        character = client.Character
    else
        character = Character.Controlled
    end

    if character == nil then return end
 character.GiveMoney(MoneyAmount);
end)
