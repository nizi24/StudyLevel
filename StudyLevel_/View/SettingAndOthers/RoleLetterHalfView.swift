//
//  RoleLetterHalfView.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/12/23.
//

import SwiftUI

struct RoleLetterHalfView: View {
    var body: some View {
        Group {
            Group {
                Divider()
                Text("第７条（著作権）")
                    .bold()
                Group {
                    Text("""
                       1. ユーザーは，自ら著作権等の必要な知的財産権を有するか，または必要な権利者の許諾を得た文章，画像や映像等の情報に関してのみ，本サービスを利用し，投稿ないしアップロードすることができるものとします。
                    """)
                        .padding(.top)
                    Text("""
                    2. ユーザーが本サービスを利用して投稿ないしアップロードした文章，画像，映像等の著作権については，当該ユーザーその他既存の権利者に留保されるものとします。ただし，StudyLevelは，本サービスを利用して投稿ないしアップロードされた文章，画像，映像等について，本サービスの改良，品質の向上，または不備の是正等ならびに本サービスの周知宣伝等に必要な範囲で利用できるものとし，ユーザーは，この利用に関して，著作者人格権を行使しないものとします。
                    """)
                    Text("""
                       3. 前項本文の定めるものを除き，本サービスおよび本サービスに関連する一切の情報についての著作権およびその他の知的財産権はすべてStudyLevelまたはStudyLevelにその利用を許諾した権利者に帰属し，ユーザーは無断で複製，譲渡，貸与，翻訳，改変，転載，公衆送信（送信可能化を含みます。），伝送，配布，出版，営業使用等をしてはならないものとします。
                    """)
                }
                .padding(.horizontal)
                .padding(.bottom)
                Divider()
                Text("第８条（利用制限および登録抹消）")
                    .bold()
                Text("""
                1. StudyLevelは，ユーザーが以下のいずれかに該当する場合には，事前の通知なく，投稿データを削除し，ユーザーに対して本サービスの全部もしくは一部の利用を制限しまたはユーザーとしての登録を抹消することができるものとします。
                """)
                    .padding()
                Group {
                    HStack {
                        Text("①. 本規約のいずれかの条項に違反した場合")
                        Spacer()
                    }
                    HStack {
                        Text("②. 登録事項に虚偽の事実があることが判明した場合")
                        Spacer()
                    }
                    HStack {
                        Text("③. 決済手段として当該ユーザーが届け出たクレジットカードが利用停止となった場合")
                        Spacer()
                    }
                    HStack {
                        Text("④. 料金等の支払債務の不履行があった場合")
                        Spacer()
                    }
                    HStack {
                        Text("⑤. StudyLevelからの連絡に対し，一定期間返答がない場合")
                        Spacer()
                    }
                    HStack {
                        Text("⑥. 本サービスについて，最終の利用から一定期間利用がない場合")
                        Spacer()
                    }
                    HStack {
                        Text("⑦. その他，StudyLevelが本サービスの利用を適当でないと判断した場合")
                        Spacer()
                    }
                }
                .padding(.horizontal)
                .padding(.bottom)
                .padding(.leading, 30)
                Group {
                    Text("2. 前項各号のいずれかに該当した場合，ユーザーは，当然にStudyLevelに対する一切の債務について期限の利益を失い，その時点において負担する一切の債務を直ちに一括して弁済しなければなりません。")
                    Text("3. StudyLevelは，本条に基づきStudyLevelが行った行為によりユーザーに生じた損害について，一切の責任を負いません。")
                }
                .padding(.horizontal)
                .padding(.bottom)
            }
            Group {
                Divider()
                Text("第９条（保証の否認および免責事項）")
                    .bold()
                Text("""
                   1. StudyLevelは，本サービスに事実上または法律上の瑕疵（安全性，信頼性，正確性，完全性，有効性，特定の目的への適合性，セキュリティなどに関する欠陥，エラーやバグ，権利侵害などを含みます。）がないことを明示的にも黙示的にも保証しておりません。
                """)
                    .padding()
                Group {
                    Text("""
                       2. StudyLevelは，本サービスに起因してユーザーに生じたあらゆる損害について一切の責任を負いません。ただし，本サービスに関するStudyLevelとユーザーとの間の契約（本規約を含みます。）が消費者契約法に定める消費者契約となる場合，この免責規定は適用されません。
                    """)
                    Text("""
                       3. 前項ただし書に定める場合であっても，StudyLevelは，StudyLevelの過失（重過失を除きます。）による債務不履行または不法行為によりユーザーに生じた損害のうち特別な事情から生じた損害（StudyLevelまたはユーザーが損害発生につき予見し，または予見し得た場合を含みます。）について一切の責任を負いません。また，StudyLevelの過失（重過失を除きます。）による債務不履行または不法行為によりユーザーに生じた損害の賠償は，ユーザーから当該損害が発生した月に受領した利用料の額を上限とします。
                    """)
                    Text("""
                       4. StudyLevelは，本サービスに関して，ユーザーと他のユーザーまたは第三者との間において生じた取引，連絡または紛争等について一切責任を負いません。
                    """)
                }
                .padding(.horizontal)
                .padding(.bottom)
            }
            Group {
                Divider()
                Text("第１０条（サービス内容の変更等")
                    .bold()
                Text("""
                StudyLevelは，ユーザーに通知することなく，本サービスの内容を変更しまたは本サービスの提供を中止することができるものとし，これによってユーザーに生じた損害について一切の責任を負いません。
                """)
                    .padding()
                Divider()
                Text("第１１条（利用規約の変更）")
                    .bold()
                Text("""
                StudyLevelは，必要と判断した場合には，ユーザーに通知することなくいつでも本規約を変更することができるものとします。なお，本規約の変更後，本サービスの利用を開始した場合には，当該ユーザーは変更後の規約に同意したものとみなします。
                """)
                    .padding()
                Divider()
                Text("第１２条（個人情報の取扱い）")
                    .bold()
                Text("StudyLevelは，本サービスの利用によって取得する個人情報については，「プライバシーポリシー」に従い適切に取り扱うものとします。")
                    .padding()
            }
            Group {
                Divider()
                Text("第１３条（通知または連絡）")
                    .bold()
                Text("""
                ユーザーとStudyLevelとの間の通知または連絡は，StudyLevelの定める方法によって行うものとします。StudyLevelは,ユーザーから,StudyLevelが別途定める方式に従った変更届け出がない限り,現在登録されている連絡先が有効なものとみなして当該連絡先へ通知または連絡を行い,これらは,発信時にユーザーへ到達したものとみなします。
                """)
                    .padding()
                Divider()
                Text("第１４条（権利義務の譲渡の禁止）")
                    .bold()
                Text("ユーザーは，StudyLevelの書面による事前の承諾なく，利用契約上の地位または本規約に基づく権利もしくは義務を第三者に譲渡し，または担保に供することはできません。")
                    .padding()
                Divider()
                Text("第１５条（準拠法・裁判管轄）")
                    .bold()
                Group {
                    Text("1. 本規約の解釈にあたっては，日本法を準拠法とします。")
                        .padding(.top)
                    Text("2. 本サービスに関して紛争が生じた場合には，StudyLevelの本店所在地を管轄する裁判所を専属的合意管轄とします。")
                }
                .padding(.horizontal)
                .padding(.bottom)
            }
            HStack {
                Text("以上")
                    .padding()
                Spacer()
            }

        }
    }
}

struct RoleLetterHalfView_Previews: PreviewProvider {
    static var previews: some View {
        RoleLetterHalfView()
    }
}
