# Copyright 2012 the rootpy developers
# distributed under the terms of the GNU General Public License
import unittest
import ROOT
from rootpy import stl
from rootpy.stl import CPPType, generate
from rootpy.testdata import get_file
from rootpy.extern.pyparsing import ParseException

GOOD = [
    'std::pair<vector<const int*>, double>*',
    'pair<vector<int>, vector<double> >',
    'vector<vector<vector<double> > >::iterator*',
    'map<int, string>',
    'map<int, vector<double> >',
    'map<int, vector<vector<double> > >',
    'vector<unsigned int>',
    'vector<const int*>',
    'vector<unsigned int>',
]

BAD = [
    'pair<vector<int>,double>>',
    'pair<vector<int>,,vector<double> >',
    'vector<<vector<vector<double> > >',
    'int,string',
    'int,vector<double> >',
    'vector<double> >',
    'map<int,vector<vector<double> > >,',
]

class TestRoot(unittest.TestCase):
    """Test to see if rootpy can generate stl dictionaries
    """
    def test_parse(self):
        for template in GOOD:
            self.assertEqual(template, str(CPPType.from_string(template)))
        for template in BAD:
            self.assertRaises(ParseException, CPPType.from_string, template)



    def test_stl(self):
        generate('map<int,vector<float> >', '<vector>;<map>')
        generate('map<int,vector<int> >', '<vector>;<map>')
        generate('vector<TLorentzVector>', '<vector>;TLorentzVector.h')

        ROOT.std.map('int,vector<float>')
        ROOT.std.map('int,vector<int>')
        ROOT.std.vector('TLorentzVector')

        temp = CPPType.from_string('vector<vector<vector<int> > >')
        temp.ensure_built()

        stl.vector('vector<map<int, string> >')
        stl.vector(stl.string)()
        stl.vector('string')()
        stl.vector(int)

        stl.map("string", "string")
        stl.map(stl.string, stl.string)
        stl.map(int, stl.string)
        stl.map(stl.string, int)
        stl.map("string", ROOT.TLorentzVector)

        histmap = stl.map("string", ROOT.TH1D)()
        a = ROOT.TH1D("a", "a", 10, -1, 1)
        histmap["a"] = a

        #StrHist = stl.pair(stl.string, "TH1*")

        #generate('pair<map<string,TH1*>::iterator,bool>', '<map>;<TH1.h>')
        #histptrmap = stl.map(stl.string, "TH1*")()
        #histptrmap.insert(StrHist("test", a))

        self.assertEqual(type(histmap["a"]), type(a))

if __name__ == '__main__':
    unittest.main()
