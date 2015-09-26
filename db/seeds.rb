# coding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Product.create!(name: 'Lemon 柠檬', thumb: '["柠檬.png"]', price: 25, taste: '酸爽清新', crafts: '每日榨取新鲜柠檬汁与鸡蛋黄油调和熬制成最美味的柠檬馅融于杯底之中，再将柠檬皮屑融于奶油中制成', efficacy: '美白护肤', tips: '摘取奶油上的鲜柠檬，切片泡水搭配蛋糕食用更美味', inventory: 30)
Product.create!(name: 'GreenTea 绿茶', thumb: '["绿茶.png"]', price: 25, taste: '苦中生甜', crafts: '将绿茶研磨成粉，加入新鲜的牛奶及奶油熬制成抹茶酱融于杯底之中，再将绿茶粉混合调入奶油中制成', efficacy: '清热提神', tips: '搭配一杯淡淡的绿茶，神清气爽', inventory: 30)
Product.create!(name: 'Velet 红丝绒', thumb: '["红丝绒.png"]', price: 25, taste: '香甜浓郁', crafts: '将巧克力熬制成酱融入特制的杯底之中，将黄油和乳酪混合打发成特制奶油花制成', efficacy: '温暖治愈', tips: '搭配一杯清香花茶，心情瞬间美丽', inventory: 30)
Product.create!(name: 'BlackTea 红茶', thumb: '["红茶.png"]', price: 25, taste: '清香醇厚', crafts: '将新鲜苹果加入红茶水中熬制成酱融于杯底之中，再将红茶粉混合调入奶油中制成', efficacy: '美容醒脑', tips: '搭配一杯清新红茶，温润甜醇', inventory: 30)
Product.create!(name: 'Ginger 生姜', thumb: '["生姜.png"]', price: 25, taste: '酸甜温热', crafts: '冰糖与白醋秘制成酸爽姜块，将姜块切成碎屑与红糖及面粉调制杯底，将黄油和乳酪混合打发成特制奶油花制成', efficacy: '养颜祛寒', tips: '摘取奶油上的特制姜块泡水，从内而外的温暖', inventory: 30)
