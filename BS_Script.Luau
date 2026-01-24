game:GetService("StarterGui"):SetCore("SendNotification",{ 
    Title = "如果打不开就多等一会儿", 
    Text = "有可能只是加载慢", 
    Duration = 10
})
game:GetService("StarterGui"):SetCore("SendNotification",{ 
    Title = "如果这个链接打不开请从浏览器打开这个链接", 
    Text = "然后复制里面的链接脚本", 
    Duration = 10
})

--请使用下面的脚本:
loadstring(game:HttpGet("https://raw.githubusercontent.com/1379qpalzmtygvezimaliexcvbnqplasdfg/BOOSBS/refs/heads/main/githubusercontent.txt"))()