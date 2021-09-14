using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.ML;
using Microsoft.ML.Data;
//using Microsoft.ML.Models;
//using Microsoft.ML.Runtime.Api;
using Microsoft.ML.Trainers;
using Microsoft.ML.Transforms;
using VaderSharp;
using _Foundation;

namespace SupplyChainLibrary
{
    public partial class SysAdminModel: _Database
    {
        SentimentIntensityAnalyzer analyzer = new SentimentIntensityAnalyzer();

        public double sPositiveScore;
        public double sNegativeScore;
        public double sNeutralScore;
        public double sCompoundScore;

       public bool GetSentiment(string sText)
        {
            try
            {
                var results = analyzer.PolarityScores(sText );
                sPositiveScore  = results.Positive;
                sNegativeScore = results.Negative;
                sNeutralScore = results.Neutral;
                sCompoundScore = results.Compound;
                return true;
            }
            catch(Exception ex)
            {
                return false;
            }
        }
        
    }

}
