#include <iostream>
#include <fstream>
#include <vector>
#include "TF1.h"
#include "TGraph.h"
#include "TVectorD.h"
#include "TVectorF.h"
#include <climits> // for INT_MAX limits

using std::cout;
using std::endl;


void pulses() {

vector<double> amplitude;
vector<double> amplitudex;

vector<double> time;
vector<double> timex;


string input = "rawtpcmonitor-2";


TFile *f = new TFile(Form("%s.root",input.c_str()));
TDirectory *d = f->GetDirectory("sspmonitor");
TH1D *he = (TH1D*)d->Get("EventNumber");
cout<< "Total events in file: " << he->GetEntries()<<endl;
Int_t ne=he->GetEntries();
TH1D *h[ne];
TH1D *hx[ne];

int evtn = 2001	; //1597-1961 - 1248 - 653 - 1413 - 1861 - 1725 - 1983;
double o=0;
double p=0;
double q=0;
double r=0;
double u=0;
double aa=0;

TH1D *meanv = new TH1D("meanv","meanv",200,1500,1650);
TH1D *meanvx = new TH1D("meanvx","meanvx",200,1480,1600);

for(int t=0;t<ne;t++){

vector<double> x;
vector<double> y;

h[t] = (TH1D*)d->Get(Form("evt%i_channel3",t+1));
hx[t] = (TH1D*)d->Get(Form("evt%i_channel7",t+1));

if(h[t] != NULL && hx[t] != NULL){
r++;

//cout<< "Event: " << t+1 << " r: " << r <<endl;
//cout << r++ <<endl;  
Double_t mean=h[t]->Integral(0,600,"width")/600;
Double_t meanx=hx[t]->Integral(0,600,"width")/600;
meanv->Fill(mean);
meanvx->Fill(meanx);
//cout << "Integral: " <<h[t]->Integral(0,600,"width")/600<< " r: " <<r<<endl;

Double_t fs = h[t]->GetBinContent(1);
Double_t fx = hx[t]->GetBinContent(1);


for(int i=1 ; i<h[t]->GetNbinsX()+1 ; ++i) {
x.push_back(i);
y.push_back(h[t]->GetBinContent(i)-fs);
h[t]->SetBinContent(i,h[t]->GetBinContent(i)-fs);
hx[t]->SetBinContent(i,hx[t]->GetBinContent(i)-fx);

}


Int_t mm=x.size();

Double_t vx[mm];
Double_t vy[mm];

for(int i=0 ; i<mm ; ++i) {

vx[i] = x[i];
vy[i] = y[i];

}

TSpline3 *sp = new TSpline3("sp", vx, vy, mm, "b2e2", 0, 0);

Double_t dd[mm];
for(int i=0 ; i<mm ; ++i) {

dd[i]=sp->Derivative(vx[i]);
//if(t+1==evtn)
//cout<<"Derivative: "<<dd[i]<<" t: "<< t+1 <<" x: "<< x[i] <<" y: "<< y[i] <<endl;
}

TGraph * der = new TGraph(mm,vx,dd);

Double_t fs1 = h[t]->GetBinContent(1);
Double_t fx1 = hx[t]->GetBinContent(1);


//cout<< fs1 <<endl;
//cout<<h[t]->GetListOfKeys()->Contains("TH1D")<<endl;


if(hx[t]->GetBinContent(hx[t]->GetMaximumBin())<240 || h[t]->GetBinContent(h[t]->GetMaximumBin())<240){
u++;
//cout<< "Event under 240: " << t+1 <<endl;
}

if((hx[t]->GetBinContent(hx[t]->GetMaximumBin())>14100) || (h[t]->GetBinContent(h[t]->GetMaximumBin())>14100)){
aa++;
//cout<< "Event above 14100: " << t+1 <<endl;
}




if(((hx[t]->GetBinContent(hx[t]->GetMaximumBin())<14100) && (h[t]->GetBinContent(h[t]->GetMaximumBin())<14100)) && ((hx[t]->GetBinContent(hx[t]->GetMaximumBin())>240) && (h[t]->GetBinContent(h[t]->GetMaximumBin())>240))){
//if(hx[t]-> GetXaxis()-> GetBinCenter(1200)<1000){

//cout<< "Event: " << t+1 << "Time: " << hx[t]->GetMaximumBin() <<endl;

p++;

amplitude.push_back(h[t]->GetBinContent(h[t]->GetMaximumBin()));
amplitudex.push_back(hx[t]->GetBinContent(hx[t]->GetMaximumBin()));

time.push_back(h[t]->GetMaximumBin());
timex.push_back(hx[t]->GetMaximumBin());

double maxs = h[t]->GetBinContent(h[t]->GetMaximumBin());
double maxx = hx[t]->GetBinContent(hx[t]->GetMaximumBin());

//if(h[t]->GetMaximumBin()>1000){
//cout<< "Event : " << t+1 <<endl;
//}

//if(hx[t]->GetBinContent(hx[t]->GetMaximumBin())<500 && maxx<maxs){
//cout<< "Event amp: " << t+1 <<endl;
//}
//cout<< "___________________________________________"<<endl;

if(maxx>maxs){
o++;
//cout<< "Event: " << t+1 << " ------------------------------------- "<<endl;
}
//else{

//cout<< "Event: " << t+1 << " ------------------------------------- "<<endl;

//}

//cout<< "Event: " << t+1 <<endl;
//cout<< "MaximumS: " << maxs <<endl;
//cout<< "MaximumX: " << maxx <<endl;
//cout<< "___________________________________________"<<endl;




}else{
//h[t]->Draw("same");
//cout<< "Event out cut: " << t+1 << " Time: " << h[t]->GetMaximumBin() << " Height: "<< h[t]->GetBinContent(h[t]->GetMaximumBin()) <<endl;
}

if(t+1==evtn){
new TCanvas();
hx[t]->SetLineColor(2);
hx[t]->Draw();
h[t]->Draw("same");
sp->SetLineColor(4);
sp->Draw("same");

new TCanvas();
der->Draw("APL");
}

}
else{
q++;
//cout<< "Event: " << t+1 << " doesn't exist! - q; "<< q <<endl;
}




}
cout<< "Event that does not exist in files: " << q << " - " << 100*(q)/ne << "%" <<endl;
cout<< "Event that exist in files: " << r <<endl;
cout<< "Events after cuts: "<< p <<endl;
cout<< "Event below 240ADC: " << u <<endl;
cout<< "Event above 14100ADC: " << aa <<endl;
cout<< "Events lost with cuts: "<< r-p << " "<< 100*(r-p)/r << "%" <<endl;
cout<< "Events amplitude Arapuca X > S: " << o << " - " << 100*o/p <<"%" <<endl;
cout<< "Events amplitude Arapuca X < S: " << (p-o) << " - " << 100*(p-o)/p <<"%"<<endl;


Int_t n=amplitude.size();
Int_t nx=amplitudex.size();

Double_t xl[n];
Double_t xlx[n];

Double_t t[n];
Double_t tx[n];

Double_t maxd=*max_element(amplitude.begin(),amplitude.end());
Double_t mind=*min_element(amplitude.begin(),amplitude.end());



//TH1D *ampl = new TH1D("hist","hist",10,mind-abs(maxd-mind)/(n),maxd+abs(maxd-mind)/(n));
TH1D *ampl = new TH1D("amp s","amp s",100,0,16500);
TH1D *amplx = new TH1D("amp x","amp x",100,0,16500);

TH1D *tm = new TH1D("time s","time s",200,750,1100);
TH1D *tmx = new TH1D("time x","time x",200,750,1100);

TH1D *ampdif = new TH1D("diff amp","diff amp",100,-10000,10000);

TH2D *ampxs = new TH2D("amp s-x","amp s-x",200,0,16500,200,0,16500);
TH2D *tmxs = new TH2D("time s-x","time s-x",200,750,1100,200,750,1100);
	
for(int i=0;i<n;i++){

xl[i]=amplitude[i];
t[i]=time[i];
ampl->Fill(xl[i]);
tm->Fill(t[i]);

xlx[i]=amplitudex[i];
tx[i]=timex[i];
amplx->Fill(xlx[i]);
tmx->Fill(tx[i]);

ampxs->Fill(xl[i],xlx[i]);
tmxs->Fill(t[i],tx[i]);

ampdif->Fill(xlx[i]-xl[i]);

}



//new TCanvas();
//ampdif->Draw();

TGraph *g = new TGraph(n,xl,xlx);
g->SetTitle("amp s - x fit");


//new TCanvas();
//g->Draw("AP");
//g->Fit("pol1");

TFile *out = new TFile (Form("%s-out.root",input.c_str()),"RECREATE");

/*
new TCanvas();
ampl->Draw();
amplx->SetLineColor(2);
amplx->Draw("same");

new TCanvas();
ampxs->Draw("colz");

new TCanvas();
TProfile *prof = ampxs->ProfileX();
prof->Fit("pol1");
prof->Draw("colz");

cout<<ampxs->GetCorrelationFactor()<<endl;


new TCanvas();
tmxs->Draw("colz");

new TCanvas();
tm->Draw();
tmx->SetLineColor(2);
tmx->Draw("same");

new TCanvas();
meanvx->SetLineColor(2);
meanvx->Draw();
meanv->Draw("same");

*/

ampl->Write();
amplx->Write();
ampxs->Write();
tm->Write();
tmx->Write();
tmxs->Write();
meanv->Write();
meanvx->Write();
ampdif->Write();
g->Write();
}





