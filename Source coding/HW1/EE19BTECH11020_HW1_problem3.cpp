#include <bits/stdc++.h>
using namespace std;

double entropy(vector<double> prob){
	double h = 0;
	for(int i=0;i<(int)prob.size();i++){
		if(prob[i]>0)
			h -= prob[i]*log2(prob[i]);
	}
	return h;
}

int main(){
	
	string inp;
	ifstream MyReadFile("inputfile_problem3_28.txt");
    getline (MyReadFile,inp);
    int total=inp.length();
    
	vector<int> count(256,0);
	vector<double> prob(256,0);
    vector<vector<int>> paircount(256 , vector<int> (256, 0));
    vector<double> pairprob(256*256,0);
	
    for(int i=0;i<total;i++){
        int x = (int)inp[i];
        count[x]++;
        
        if(i+1!=total){
            int y = (int)inp[i+1];
            paircount[x][y]++;
        }
    }

	for(int i=0;i<256;i++){
	    
	    if(count[i]!=0)
			prob[i]=(double)count[i]/total;
			
	    for(int j=0;j<256;j++){
	        if(paircount[i][j]!=0)
	            pairprob[i*256 + j] = (double)paircount[i][j]/(total-1);
	    }
	}
	
	double H = entropy(prob);
	double Hx1x2 = entropy(pairprob);
	double Hx2gx1 = Hx1x2 - H;
	
    cout << "Total characters = " << total << endl;
    cout << "Entropy H(x) = " << setprecision (9) << H << endl; 
	cout << "Optimal compressed filesize with individual entropy in bytes = " << setprecision (9) << total*((H/8)) << endl;   //printing size of compressed file
	cout << "Conditional entropy H(X2|X1) = " << setprecision (9) << Hx2gx1 << endl;
	cout << "Optimal compressed filesize with conditional entropy in bytes = " << setprecision (9) << (total-1)*Hx2gx1/8 << endl;
	cout << "Filesize using zip in bytes =  1604" << endl;
}
