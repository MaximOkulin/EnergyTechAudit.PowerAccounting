namespace EnergyTechAudit.PowerAccounting.ReportSupport.Types
{
    public struct Km5ErrorTimes
    {
        public int U { get; set; }
        public int E { get; set; }
        public int D { get; set; }
        public int g { get; set; }
        public int G { get; set; }

        public static Km5ErrorTimes operator +(Km5ErrorTimes times1, Km5ErrorTimes times2)
        {
            var result = new Km5ErrorTimes();
            result.D = times1.D + times2.D;
            result.E = times1.E + times2.E;
            result.U = times1.U + times2.U;
            result.g = times1.g + times2.g;
            result.G = times1.G + times2.G;

            return result;
        }

        public bool IsEmpty()
        {
            return U == 0 && E == 0 && D == 0 && g == 0 && G == 0;
        }
    }
}
