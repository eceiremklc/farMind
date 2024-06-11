Projenin Özeti

Bu çalışmanın amacı, tarım arazilerinde yetiştirilen ürünlerin optimum koşullarda, minimum israfla üretimini sağlamaktır. Bu doğrultuda, çeşitli sensörler kullanılarak her saat başı topraktaki nem miktarı, hava sıcaklığı ve havadaki nem oranı ölçülmektedir. Ölçülen veriler bir veri tabanında saklanmakta ve kullanıcılar bu verilere mobil uygulama üzerinden erişebilmektedir. Ayrıca, mobil uygulama üzerinden anlık hava durumu ve beş günlük hava tahmini sağlayan bir API bulunmaktadır.
Sulama işlemleri belirli saatlerde otomatik olarak gerçekleştirilmektedir. Eğer topraktaki nem seviyesi belirlenen eşik değerin altında ve hava durumu yağmurlu değilse, sistem otomatik olarak sulama yapmaktadır. Bunun yanı sıra, kullanıcılar mobil uygulamadaki bir anahtar yardımıyla sulama işlemini manuel olarak da gerçekleştirebilmektedir.
Ek olarak, Google Gemini API kullanılarak oluşturulan bir mesajlaşma sayfası üzerinden kullanıcılar, bitkilerinin fotoğrafını göndererek bitki türü ve yetiştirilmesi için gereken optimum koşullar hakkında bilgi alabilmektedir.

![image](https://github.com/eceiremklc/farMind/assets/82780670/2a7f62b6-dd1a-45e8-8c89-19aad25663e4)

Bu şekil, bir tarım arazisinde sensörler ve otomasyon sistemleri kullanarak optimum üretim koşullarının sağlanmasını göstermektedir. Toprak nemi, hava sıcaklığı ve nemi gibi veriler sensörler aracılığıyla ölçülüp, Arduino Uno tarafından toplanarak Raspberry Pi 4'e iletilir. Raspberry Pi 4, bu verileri Cloud Firestore veri tabanına kaydeder ve mobil uygulama aracılığıyla kullanıcılara sunar. Kullanıcılar, mobil uygulama üzerinden sulama işlemlerini otomatik veya manuel olarak kontrol edebilir.

![image](https://github.com/eceiremklc/farMind/assets/82780670/f2566dca-7c64-4ed2-ab1e-6a0d82915fde)


