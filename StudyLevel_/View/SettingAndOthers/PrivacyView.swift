//
//  PrivacyView.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/12/23.
//

import SwiftUI

struct PrivacyView: View {
    var body: some View {
        ScrollView {
            Group {
                Group {
                    Text("StudyLevelは，本ウェブサイト上で提供するサービス（以下,「本サービス」といいます。）における，ユーザーの個人情報の取扱いについて，以下のとおりプライバシーポリシー(以下，「本ポリシー」といいます。）を定めます。")
                        .padding()
                        .font(.callout)
                    Divider()
                    Text("第１条（個人情報）")
                        .bold()
                    Text("""
                        「個人情報」とは，個人情報保護法にいう「個人情報」を指すものとし，生存する個人に関する情報であって，当該情報に含まれる氏名，生年月日，住所，電話番号，連絡先その他の記述等により特定の個人を識別できる情報及び容貌，指紋，声紋にかかるデータ，及び健康保険証の保険者番号などの当該情報単体から特定の個人を識別できる情報（個人識別情報）を指します。
                    """)
                        .padding()
                        .font(.callout)
                    Divider()
                    Text("第２条（個人情報の収集方法）")
                        .bold()
                    Text("""
                        StudyLevelは，ユーザーが利用登録をする際に氏名，生年月日，住所，電話番号，メールアドレス，銀行口座番号，クレジットカード番号，運転免許証番号などの個人情報をお尋ねすることがあります。また，ユーザーと提携先などとの間でなされたユーザーの個人情報を含む取引記録や決済に関する情報を,StudyLevelの提携先（情報提供元，広告主，広告配信先などを含みます。以下，｢提携先｣といいます。）などから収集することがあります。
                    """)
                        .padding()
                        .font(.callout)
                    Divider()
                    Text("第３条（個人情報を収集・利用する目的）")
                        .bold()
                    Text("""
                        StudyLevelが個人情報を収集・利用する目的は，以下のとおりです。
                    """)
                        .padding()
                        .font(.callout)
                }
                Group {
                    Text("""
                        1. ユーザーに自分の登録情報の閲覧や修正，利用状況の閲覧を行っていただくために，氏名，住所，連絡先，支払方法などの登録情報，利用されたサービスや購入された商品，およびそれらの代金などに関する情報を表示する目的
                    """)
                    Text("""
                       2. ユーザーにお知らせや連絡をするためにメールアドレスを利用する場合やユーザーに商品を送付したり必要に応じて連絡したりするため，氏名や住所などの連絡先情報を利用する目的
                    """)
                    Text("""
                        ３. ユーザーの本人確認を行うために，氏名，生年月日，住所，電話番号，銀行口座番号，クレジットカード番号，運転免許証番号，配達証明付き郵便の到達結果などの情報を利用する目的
                    """)
                    Text("""
                        4. ユーザーに代金を請求するために，購入された商品名や数量，利用されたサービスの種類や期間，回数，請求金額，氏名，住所，銀行口座番号やクレジットカード番号などの支払に関する情報などを利用する目的
                    """)
                    Text("""
                       5. ユーザーが簡便にデータを入力できるようにするために，StudyLevelに登録されている情報を入力画面に表示させたり，ユーザーのご指示に基づいて他のサービスなど（提携先が提供するものも含みます）に転送したりする目的
                    """)
                    Text("""
                        6. 代金の支払を遅滞したり第三者に損害を発生させたりするなど，本サービスの利用規約に違反したユーザーや，不正・不当な目的でサービスを利用しようとするユーザーの利用をお断りするために，利用態様，氏名や住所など個人を特定するための情報を利用する目的
                    """)
                    Text("""
                       7. ユーザーからのお問い合わせに対応するために，お問い合わせ内容や代金の請求に関する情報などStudyLevelがユーザーに対してサービスを提供するにあたって必要となる情報や，ユーザーのサービス利用状況，連絡先情報などを利用する目的
                    """)
                    HStack {
                        Text("  8. 上記の利用目的に付随する目的")
                        Spacer()
                    }
                }
                .font(.callout)
                .padding(.horizontal)
                .padding(.bottom)
                Divider()
                Text("第４条（利用目的の変更）")
                    .bold()
                VStack {
                    Text("""
                       1. StudyLevelは，利用目的が変更前と関連性を有すると合理的に認められる場合に限り，個人情報の利用目的を変更するものとします。
                    """)
                        .padding()
                    Text("""
                       2. 利用目的の変更を行った場合には，変更後の目的について，所定の方法により，ユーザーに通知し，または本ウェブサイト上に公表するものとします。
                    """)
                        .padding(.horizontal)
                        .padding(.bottom)
                }
                .font(.callout)
            }
            Divider()
            Text("第５条（個人情報の第三者提供）")
                .bold()
            Group {
                VStack {
                    Text("""
                        1. StudyLevelは，次に掲げる場合を除いて，あらかじめユーザーの同意を得ることなく，第三者に個人情報を提供することはありません。ただし，個人情報保護法その他の法令で認められる場合を除きます。
                    """)
                        .padding()
                    Group {
                        HStack {
                            Text("①. 法令に基づく場合")
                            Spacer()
                        }
                        HStack {
                            Text("②. 人の生命，身体または財産の保護のために必要がある場合であって，本人の同意を得ることが困難であるとき")
                            Spacer()
                        }
                        HStack {
                            Text("③. 公衆衛生の向上または児童の健全な育成の推進のために特に必要がある場合であって，本人の同意を得ることが困難であるとき")
                            Spacer()
                        }
                        HStack {
                            Text("""
                            ④. 国の機関もしくは地方公共団体またはその委託を受けた者が法令の定める事務を遂行することに対して協力する必要がある場合であって，本人の同意を得ることにより当該事務の遂行に支障を及ぼすおそれがあるとき
                            """)
                            Spacer()
                        }
                        HStack {
                            Text("⑤. 予め次の事項を告知あるいは公表をしている場合")
                            Spacer()
                        }
                        Group {
                            HStack {
                                Text("一、 利用目的に第三者への提供を含むこと")
                                Spacer()
                            }
                            HStack {
                                Text("二、 第三者に提供されるデータの項目")
                                Spacer()
                            }
                            HStack {
                                Text("三、 第三者への提供の手段または方法")
                                Spacer()
                            }
                            HStack {
                                Text("四、 本人の求めに応じて個人情報の第三者への提供を停止すること")
                                Spacer()
                            }
                        }
                        .padding(.leading, 30)
                    }
                    .padding(.leading, 50)
                    .padding(.bottom)
                    HStack {
                        Text("2. 前項の定めにかかわらず，次に掲げる場合は第三者には該当しないものとします。")
                            .padding(.horizontal)
                            .padding(.bottom)
                        Spacer()
                    }
                    Group {
                        HStack {
                            Text("①. StudyLevelが利用目的の達成に必要な範囲内において個人情報の取扱いの全部または一部を委託する場合")
                            Spacer()
                        }
                        HStack {
                            Text("②. 合併その他の事由による事業の承継に伴って個人情報が提供される場合")
                            Spacer()
                        }
                        Text("""
                        ③. 個人情報を特定の者との間で共同して利用する場合であって，その旨並びに共同して利用される個人情報の項目，共同して利用する者の範囲，利用する者の利用目的および当該個人情報の管理について責任を有する者の氏名または名称について，あらかじめ本人に通知し，または本人が容易に知り得る状態に置いているとき
                        """)
                            .padding(.trailing)
                    }
                    .padding(.leading, 50)
                    .padding(.bottom)
                }
                .font(.callout)
                Divider()
                Text("第６条（個人情報の開示）")
                    .bold()
                Group {
                    Text("""
                    1. StudyLevelは，本人から個人情報の開示を求められたときは，本人に対し，遅滞なくこれを開示します。ただし，開示することにより次のいずれかに該当する場合は，その全部または一部を開示しないこともあり，開示しない決定をした場合には，その旨を遅滞なく通知します。なお，個人情報の開示に際しては，１件あたり１，０００円の手数料を申し受けます。
                    """)
                        .padding(.top)
                    Group {
                        HStack {
                            Text("①. 本人または第三者の生命，身体，財産その他の権利利益を害するおそれがある場合")
                            Spacer()
                        }
                        HStack {
                            Text("②. StudyLevelの業務の適正な実施に著しい支障を及ぼすおそれがある場合")
                            Spacer()
                        }
                        HStack {
                            Text("③. その他法令に違反することとなる場合")
                            Spacer()
                        }
                    }
                    .padding(.leading, 30)
                    HStack {
                        Text("2. 前項の定めにかかわらず，履歴情報および特性情報などの個人情報以外の情報については，原則として開示いたしません。")
                        Spacer()
                    }
                }
                .padding(.bottom)
                .padding(.horizontal)
                Divider()
                Text("第７条（個人情報の訂正および削除）")
                    .bold()
                Group {
                    Text("""
                    1. ユーザーは，StudyLevelの保有する自己の個人情報が誤った情報である場合には，StudyLevelが定める手続きにより，StudyLevelに対して個人情報の訂正または削除を請求することができます。
                """)
                        .padding(.top)
                    Text("""
                    2. StudyLevelは，ユーザーから前項の請求を受けてその請求に応じる必要があると判断した場合には，遅滞なく，当該個人情報の訂正または削除を行い，これをユーザーに通知します。
                    """)
                }
                .padding(.bottom)
                .padding(.horizontal)
            }
            Group {
                Divider()
                Text("第８条（個人情報の利用停止等）")
                    .bold()
                Text("""
                    StudyLevelは，本人から，個人情報が，利用目的の範囲を超えて取り扱われているという理由，または不正の手段により取得されたものであるという理由により，その利用の停止または消去（以下，「利用停止等」といいます。）を求められた場合には，遅滞なく必要な調査を行い，その結果に基づき，個人情報の利用停止等を行い，その旨本人に通知します。ただし，個人情報の利用停止等に多額の費用を有する場合その他利用停止等を行うことが困難な場合であって，本人の権利利益を保護するために必要なこれに代わるべき措置をとれる場合は，この代替策を講じます。
                """)
                    .padding()
                Divider()
                Text("第９条（プライバシーポリシーの変更）")
                    .bold()
                Group {
                    HStack {
                        Text("1. 本ポリシーの内容は，ユーザーに通知することなく，変更することができるものとします。")
                            .padding(.top)
                        Spacer()
                    }
                    HStack {
                        Text("2. StudyLevelが別途定める場合を除いて，変更後のプライバシーポリシーは，本ウェブサイトに掲載したときから効力を生じるものとします。")
                        Spacer()
                    }
                }
                .padding(.bottom)
                .padding(.horizontal)
                Divider()
                Text("第１０条（お問い合わせ窓口")
                    .bold()
                Text("本ポリシーに関するお問い合わせは，下記の窓口までお願いいたします。")
                    .padding()
                Text("メールアドレス：polpa.contact@gmail.com")
                    .padding(.bottom)
                    .padding(.horizontal)
            }
            HStack {
                Text("以上")
                Spacer()
            }
            .padding()
        }
        .navigationBarTitle(Text("プライバシーポリシー"), displayMode: .inline)
    }
}

struct PrivacyView_Previews: PreviewProvider {
    static var previews: some View {
        PrivacyView()
    }
}
