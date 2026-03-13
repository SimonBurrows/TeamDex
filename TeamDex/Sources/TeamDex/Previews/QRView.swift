//
//  QRCard.swift
//  TeamDex
//
//  Created by Simon Burrows on 12/03/2026.
//

import SwiftUI
import CoreImage.CIFilterBuiltins

struct QRCodeView: View {
    let payload: String

    private let context = CIContext()
    private let filter = CIFilter.qrCodeGenerator()

    var body: some View {
        VStack(spacing: 16) {
            if let image = makeQRCode(from: payload) {
                Image(uiImage: image)
                    .interpolation(.none)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 280, height: 280)
                    .padding()
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
            } else {
                Text("Failed to generate QR code")
            }

            Text(payload)
                .font(.footnote.monospaced())
                .lineLimit(3)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        }
    }

    private func makeQRCode(from string: String) -> UIImage? {
        let data = Data(string.utf8)
        filter.setValue(data, forKey: "inputMessage")
        filter.correctionLevel = "M"

        guard let outputImage = filter.outputImage else {
            return nil
        }

        let scaledImage = outputImage.transformed(
            by: CGAffineTransform(scaleX: 12, y: 12)
        )

        guard let cgImage = context.createCGImage(scaledImage, from: scaledImage.extent) else {
            return nil
        }

        return UIImage(cgImage: cgImage)
    }
}

#Preview {
    QRCodeView(
        payload: ExampleQRCodes.fireAtTheOffice
    )
}

enum ExampleQRCodes {
    // CHatGPT's initial attempt
    static let pokemonIcebreaker = "eNq1ls9u4zYQxl+FENBbYouSLEu5tIdFCxc9FN30tCgCWqIsITIpkFS8RpAH6nP0xTrfUJs/QE+teqBGoeY3M9R8Gfk5Meqsk7vkV/v4159na8Sh0Uen1aN24ic8ukmmUV2188ndl+Rn1TzSDoy3Jt7ZI9uz9tEOmq3TLdtvfn7Sjm+u8dpq3tcqmq5jY4xa7NBFf+30+RpvXLTe68UODXsP4whj+aKWELbR45VjWx2v0ak3izEcLVZnXRvrsF5PfbzpZ5X8Qad3thtGfWj5BUh6ltHKaRW0drRKWntaFa2alkxxgaeEq4SvhLOEt4S7hL8EIEFkIDKODSIDkYHIQGQgMhAZiAxEDiIHkXM5IHIQOYgcRA4iB5GDKEAUIAoQBZ8ARAGiAFGAKEAUIHYgdiB2IHYgdnxoEDsQOxA7EDsQJYgSRAmiBFGCKPk9gShBlCBKEHsQexB7EHsQexB7EHt+tSD2IPYgKhAViApEBaICUYGoQFTcDRAViBpEDaIGUYOoQdQgahA1iJobGDvILUy5hyk3MeUuptzGlPuYciNT7mTKrUyZXdrPbBRAVECUQNRAFEFUQZQB60CyEGQWtcMsa0GyGCSrQbIcJOtBsiAkK0KyJCRrQuZReMyyLCTrQrIwJCtDsjQka0OyOCSrQ7I8ZBFVyywrRLJEJGtEskgkq0SSTOjfxGuj3GDxT/KchCGMGCr3Fyvu3Rx6L5RphRK/8HAI+mugp597GhIikE9487FGi3HQQh3tHMTVzs7rsduI+16Lk7PzJE4zJoAXoWfPTfJy85bxR/VEyBC0+DbQ3vIdOsQTF5ooVMrrwAtODUa7G3Hph6Z/27/YeWzFUXMRYlIukBfXeOmv33/I+nnSuhUHE5xt5yYM1vh3aZdt/XoaDuL59DjubGY/q1H09ni8CuvEYALV6MPHo32iqXwWn2eao5O98HD8eLCGC+7VEx3PXIV/9cTRVFgONAScCRX09rLsgZ69pmcfz/VJe+2COPgR/oegz//8Nj29Q9NqdI/ebBupgakltx/MaUQCfX6X8+hom1JCPxO6xjO2D2Hyd9stvjubyT5q6oanYlt7MZvGnreL73bpnN9SLHPy9NJuT9rIzWROVOe/DGP+G/5ahTuuEyhbJ0y+Uhjn1wlUrBSmndYJVK4U5ut1nUD7dcJU64SpVwhzVjAryIcjvP0y+017Oz7RPLx7Xn7MPieeJm3Dd+E6YZKpaaCksxvv9ZlSBuy9lkDZ6Tll3ZLZPmXbpZ5b+s3aDFTDdz/QWEwmFXrCOAf9eRzs/52qG+lz5h4wcR80fUbIYZNu3u3Clz5MF+sef3fjeuV8LGNpxcbSJ9dtbNcNzaDG2yXxpnPWhIdWd2oeqaKXl78BbdHcaA=="
    
    // Prompt:
    // This is how the game works. When I select my player name, I'm assigned a profile. I see my profile and the game scenarios. I play the scenarios as my profile. With that in mind, generate some differrent strings similar to before with different sets of fun game scenarios that use the profile in them. Think fun teambuilding exercies
    
// 🤝 Connection Quest
//    Example prompts:
//
//    • Find another Pokémon with something in common
//    • Teach the team a lesson your Pokémon would share
//    • Create a short adventure story as your Pokémon
    static let connectionQuest = "eNq1lt1upTYQx18FIfVuw8F8k5t2tdJW7VU/tupFVUUOmIMVsJExOXsU5YH6HH2xnf+YJt1edtkLMw7Mb2bM/Jmcp9jIWcW38TtrjOq8tib6eVOrj9/EyySvyq3x7R/xj7J7oDswqzVhZ+/ZzmoNViu2TvVs//FbF+V4cw3XXvF9JYMZBjbGyN3qIfgrp+Zr2Lhg11XtVnfsracJxvJF7iFsp6Yrx7YqXIPTaHZjOFqozro+1GFXtYxhM24y/pNO7+ygJ/VDzy9A0LOMVk6roFXSqmjVtBpaLS2R4gJPAVcBXwFnAW8BdwF/AUCAyEBkHBtEBiIDkYHIQGQgMhAZiBxEDiLnckDkIHIQOYgcRA4iB1GAKEAUIAo+AYgCRAGiAFGAKECUIEoQJYgSRMmHBlGCKEGUIEoQFYgKRAWiAlGBqPg9gahAVCAqEDWIGkQNogZRg6hB1PxqQdQgahANiAZEA6IB0YBoQDQgGu4GiAZEC6IF0YJoQbQgWhAtiBZEyw0MHeQWptzDlJuYchdTbmPKfUy5kSl3MuVWpszu7Wc2CCAoIEggaCCIIKggyIB1IFgIIgvaYZa1IFgMgtUgWA6C9SBYEIIVIVgSgjUh8iA8ZlkWgnUhWBiClSFYGoK1IVgcgtUhWB6iCKpllhUiWCKCNSJYJIJVIkgm9JmsykinLT6Sp9hrP4VhMs80SL53djOYBl599HT7vTZ9tNpZWaOiy0jfXPSTffj7L/iuI02OlZ/6UZtzpE3UhTAX7cfoaje3JvHzm9csH5TsxsiPKqLd/Jrm91H6aKIxAdZuU8/wayr/wp2pwCWS93bzuDtfrHv49rMcb/tHZfzmVPSrtzyH9iTvnJJeRZIKt85HK57SmWhq/SfbaqdHOpjkBFE3ymlS5qzoKHh7i9Ne8YQZvV/W29MJUzdZ7IMimGJfensxCb2J0+578k5qQ3P5RHnMefXK3ZyVEclizlTe/wxjvgx/qcLdHxMoOyZMflAYkt4hgYqDwvTLMYGqg8J8vB4TqD4mTHNMmPaAMLOEOUA+HOH1d8kvigeLi2+f9p9wT/FKg6fjnb8umF5y0ZR0c9MHNVNKj3svJVB2ek5ZT2ROj9lpr+eGfrF1mmr45jsahfEi/UgY56A/77X92qmGST5ad4dBe0fD15FDkib/ugtf6Tym9W9uOq6cz8vYW5FY+k/hEjsMutNyutkTJ4Ozxt/1apDbRBU9P38C3tZ/Sg=="
    
    // Prompt
//    now, can you try making a game that has nothing to do with pokemon? Get the images from somewhere else. The bios too, or you cna generate them yourself
    
    static let startUpSimulator = "eNqtVFFr3DAM/ismsLdy16Tbuh2MrSsUtocx2pVRxh50sXJxL7GC7PQajsL+wv7ifskkO6Xt40YfZBn5+z7JkpN94aHHYlVcROA4DubC9WMHkbg4KIYOJuRQrH4Un6HeSkRdIJ93tE6+x5C9w+QZbfL3uDAgp82UV4spjpBd0yTnPczeNRmPjP2UN5x9CDh7Vye06zp1lBaYJajGbkrahHnNoNbPzie1XB2xzXVQwKHNm3aE4qfcnqlxHX6yqQGlnFViR2IvxV6JvRY7Fnsj9lasPNRFkaVCS8WWCi4VXSq8VHyphFIZlTKqpK2MShmVMiplVMqolFEpo1LG0aHWFtADO9LK9kV0sdMRfnWxbs0VjWzmaQo+4m2Us5NgJj2oW2CoI/KBGRIcTJgn7yyCiWRii2bDpBFvjg5NwJq8DYvi7uAh16XH2wFFyJqLbR7DnOnqSRpzTc6HpBkRetHviZl2C/O9hWjGB5mgMsam/JNZs/Ob909SnmPNo4tS8Sn9+fX7jEZv00uZE585bw14Ej6b/HTNrpW5PqpmR2NnzRpTQfIuG8ltapVrspxpiHOn5rbItbXfA7uI6SG0MQ5htVzC4BbW1bhG4EVN/fJ4cbuEG4gAwGE5SPkB0b47kQr/lfPxPzinj97sOQbqbqQ5q/38fe+LIJeq0y5Og/ZThCXNyN037KVdUWP3Se3Y99O1fMEp4xjkL7B88UHGUQwQWwE2jkP8otISWzt6/gwSHsBPizx+ics4dsTbS+6eP5nrYSNJ7u7+Akr9oZ4="
    
    static let officeSurvival = "eNqtU99v1DAM/leiSLydemsHDE5CgyEkNmmAYDwgxIOvcS/h2iRK0rtVp/vfZycdP/YG2oPjyP0+f47tHqSFAeVKfuw606L4Moad2UEvF9L3MGGIcvVdXkG7pQi76Gy5uXX2A8biDWYfUGV/j4seQ75M5VSY4wjFdV121sLsTVfwGHCYyiUUHyPO3rQZbXou88rlA+YUrsV+yrkdlrOAtJ2dzdlKdS6oUoeL6HW56BHkD3p9cJ3p8VLlBtT0rSE7JXtK9ozsOdkZ2Quyl2T1CR+MrBlaM7ZmcM3omuE142sm1MxomNHk3MxomNEwo2FGw4yGGQ0zGmacnnBtES0E47iyg0wm9TzAa2cVTOLaBWvshrAJbxPFv7kxiFZDgDZhEBCC2WEUM3wocJEcY1ysxHu3F8qJpHESGqzqUZh0Lo+L31I3CANtCk3Wu30e16x12YnpbzkNSoDYu7CldaL9ir9YC7HXkOjT2CtSEGt8IKJRXJiN+BSQ3psgmTyzWendLeUzVmiq9oFkyegLjcSDidtJGIXAr+wRFG21Nr6SR+6lDyZhHrJOycfVcgneVIp+hjVCqFo3LM+q2yXsIAFAiEtvN+cRUb16Q+X8K+fiPzhv/9jHzxhdv6Oerw7zn3uQkd7f5luaPLeOEpPMGPobHKhNiWP3omochukn/Z1ZcYzUi+WT19R56SFpAnYmxPSBU1NsbdzjK1DYg52qMmmKQ0i8IV9D//hiZoANiRyPdyD/kcQ="
    
    static let creativeCollaboration = "eNqtU01vEzEQ/SuWJW5R0t0ChUgIShBSOaAKihBCHGa9k6yp116N7aSrKP+9M95UodxAPYyf1/vevBl/7LWHHvVSrwgh2S2qVXAOmkD8Fbye6cHBiBT18qf+BOaWVwRi+cez0BTsMU5osSBhW/CBFwekMhmnscWyjjDBel3AeziiXU98JOzHaUITxohHtKawrXMCoQxwTBEMurHkDjiNE6nzR/Al21RdoHaqI0QcumnSZdC/uHsKa+vwqi0bUPG/muOc4znHC46XHBccrzhec1RnMgizEmol3ErIlbAroVfCr0RQiaIWRV1yi6IWRS2KWhS1KGpR1KKoRXF+JrVF9EA2SGV7nWxyco4fMNqNV6lD9TGnTNJ9wrvEvy6jGkMmZTogMAlppqzfok8KFPfZZpNYB0ntQnat0PwGFW6RxhZG5fhM5vowO3l9DY4vDKgbhF5dU2gc9ie7H4+8VJ9jUvGoMMGvnWW/BtMOkevdBZU4TXzs8N1yIVctwinttU2mK/31gTOSba3JLuSomswGaAiTG1VDfC8scHOW5X81rgx4ZXvYWC8tyV4OZBOWQ+5SGuJysYDBzjk3Ngg0N6FfXMzvFrCFBAAUF4PfvI2I7ZtLru1fNe//Q7P64z5+wbKTpJf74wPe68gtmjJL4yCbx4nZJpO7wZ5fcZK1B9M29/34m19nccyRX/ji2Tveez1A6pi4thTTZ0nNa40NT+/AywP4cT6dNa8D8S2g22/knt5MDptNDod7xTSUkA=="
    
    // Prompt
//    Make the scenarios have more to do with the character. Make the bios and scenarios a little longer and much more fun. The sprites are good for the players but the charater profile pictures are dull. Can you get them from somewhere more fun?
    
    // Seems too big for qr code?
    static let funGame = "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"
    
    static let guildQuest = "eNrtlU2P2zYQhv8KofPWTtI0AQwURbMbBFsggLtJ0MM6B1ocSYwpUuGQ61UN//e8pOR4FfTU+KgDTUoiZx7Ox+tDYWVLxap4F7VR4u9IHIqrojOyJ8/F6r74S5Y7vEkTOzus3DbPLfEwa8qzJ5Xn0z7uyOdFP/wqyu9JDlNV5claOc66GvaTp7YfFr4vPgPHu0obulWZ6Bk+Pcd4gfErxkuM3zBeYbxO25ms9NqlzYci6GDOF7y1wTsVy6AzY6DHgG+ntyR6Fz2TqURwIjQk6nxKcv4gykZ6WQbyi+J4dTZ923aOWW8NfQ/gaPjtIyKprWjc/gcLgp15IBbSCn0+HiTvpravG+eYhBRr6UN/trzW5U6EvRNjqsS+Sfu+28cLF4H+xcF9dv01oU2Nr3Uom3zPtZFP4nHt7IO2CMc5BNkEfFmx18YIjmVJpGAuxbvzOlDOTRNCx6vlMlEtOrej1lnG7ZXb20Xp2uW4dxk84gLMJQzbmkH8S032+aKzNTj+pxmbj58L5o5ylH2xOox1figYFynzKvRdCoJxpTTw+SWV7aq4P2zy3k2x2iD60rH4R/8rvdoUV5tiq13+8DF6ywINwL3QilAg2qJkOHqAsba12HqSu9B4F+uGF/kwMrh3fvfJm2zjdEnZ6YXSJW1J+ny514vHpVQPZEP05Je40x+MYP++HzmQwieMHzp4UtwQBRSJkUrbCeoNVWQVKs5VwnksroT0LSkkMjSicr6NRqZCVIKDR2vA6WV4uxPNFPiGWNdWvPkxpu/lDg1ByFcfmhTC0sADwBNa6zwJeIxBV9Fchm/7H9G8oW2s6+T9ztWRJoAfLFLKYkyq4B5l23KSikoDsdEKCidQe2jl9kI59wPFFHI9aJi4k7YmP2GEzClEMZDMZHtcUUQmxEy4GOCJLgU2+p6SvUcVpuDdeHBMwK6lARH0yQVdonPyvqHsPIQJ6WUUYxkvhKcGgCndLTpV/GnKhlrNYdrQuA+nZmAxZDc0aQpjYyfluxCZPPuf0r2FkNV96gsUppbTLoYS+ZpGGkTRGLLpOTdxtAhg18n0FwJ/TWQtub1Yk5xwjp9BXHQyNNDJrKd4BOAsq7OszrI6y+osqz8vq0lO8XQ2P4vrLK6zuM7iOovrz4vrE1U9Ho/fAFfqrxA="
    
//    Now come up with the most fun one you can using the pokemon api
    
    static let proffessorOaksTeamMixer = "eNq1UsGO0zAQ/RXLErfdpAkssL3ACbSVEAgt4rCgyk0mjanjiexJ06jqvzPjRuxWyxEO40ns9948j+eovelAL/UX3P0YFgu47dCrT/YAQV/p3pkJQtTLB70y1Y53OOEm5Q7iOVtIOaI/5z5RV2aSFYzXP1koYGMd3NVJq+CTkuMlxyuOG47XHG843nLcchQLWQRZCLQQbCHgQtCFwAvBF0IohFEKo0zawiiFUQqjvBELEbwJFsXAUZMl9+zWd54CMp7gQHyWfuuhAjXhECK4RsHBVOQmZWLaUxf0EQdXZ/p09Sj/cerUPZjuUfSD9bWiEdXcWjW2GOEvQqrB0CmjtixBLKFGS+3ZyWWNz01j2eMqPctc5XtrSP3CzSz13Gtr9qAYM2LYvdMnaU8fLEF6npaoj8s8F4tZjztgRmxxrHH0WYVdPmNzCsZ6vkTOBfw2EoSs99sn7/0VIro9z8PyOM/ZUUc2U6Uvmnq5gOktOx+Cu4eOS5Ls/bHA1fmcq+ac8n2Zz36uecwqyx5evOdu6N5Qy7RUg383Fv93qcaZPYa1NHwNPCkMyBbZk13BmkDS4W/B/Ts7lzbmp8iQWu4+yixY467nwlkT0NO6hsYMjh2dTr8Bg+tI5w=="
    
    static let fireAtTheOffice = "eNrtlE1P20AQhv/KaC+9QNJCpUqRKkQJqFChtpCqB8Jh7B07C+tdd2dNsKL89846KfmQ2gP0gpSDE3tnPM87s+96phxWpAbqzAQCjBAnBF+LwuSk9lRtsaXAanCjji09ysqFDxqd3FxjJb8jbK0PcnOCTK38X/pQdvErY7uFC6wMqVupFXwha+e6K/dWQu/kOpDrUK73KYXJYTA+JcxUNNEmYd+C100ejXcw9NNUOtJjlMAlGgf1Igq+KKxx1IMh5UYTFCZwaiaQdNW9zdD6JkDwliDiPTFEr7HtqfneCnbsytDCScPRVxTWWXc+QL5c7+piJJdqgCV8EPDPiUxPe1rnaA+iMY3USR2YSOBog3cmZRoZ/JBQJ/0r4p9IJUzgiakXciFrIhh2byKIBN0uuTGgpn0ZwrYCbsqSOG5SrylvgoktyKaGuGI+rRvmRtQbzv0DBdJ/7S6jwotIclp2AETfJmhEWMGJd7I3+RpnNPUQJcSQWXEfEOYT8DKmAFIOEAo0VprvwWc/3aZWIimlTTFooSXb1CKaOltNYqx50O9jbXpaPJwRhl7uq/6H3mO/No9k9zHEfu3KIybSHxcGT0Z83psHz37zcO1MXBF7K4NWg9nyOM4US8N5dxfbOs3S+hyt4O7YO3m8mY273LEajNUnzO/THpy6UkxEYaz2xiozfhFsjNUMKPFC1DAwhQfRyb0uTbRNfbj/EWyX/c9uMh9j5FUr2YI7Tpu+Jmd5ZOESHZZbar7JAZftMixCEvflIpafgG0RQ2JTui36eSXZD4JuGDNjxesv5+sn0KaA66vTDfYXolqG33IkcT5HzCy9nM6BtsHfj2EkZ36r9TPjxAXpW5Q15X/Y+18o3FtBqxrjRBzZOVceBbgz8M7Ar8/AybjytKq5s/HOxq/Pxmv+nc/nvwH23xmb"
}
