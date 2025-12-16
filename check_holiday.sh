#!/bin/bash

####################################
# Holiday Detection Script
# - Checks if today is a weekend
# - Checks if today is a Taiwan national holiday
# Returns: 0 if working day, 1 if holiday
####################################

# Get today's date
TODAY=$(date +%Y-%m-%d)
YEAR=$(date +%Y)
DAY_OF_WEEK=$(date +%u)   # 1=Mon ... 6=Sat 7=Sun

# ---- Check weekend ----
if [ "$DAY_OF_WEEK" -ge 6 ]; then
  echo "$(date) | 🟡 Weekend detected (Day $DAY_OF_WEEK), skipping attendance"
  exit 1
fi

# ---- Taiwan National Holidays for 2025 ----
# Update this array each year
HOLIDAYS_2025=(
  "2025-01-01"  # New Year's Day (元旦)
  "2025-01-27"  # Lunar New Year's Eve (除夕前一日調整放假)
  "2025-01-28"  # Lunar New Year's Eve (除夕)
  "2025-01-29"  # Spring Festival (春節初一)
  "2025-01-30"  # Spring Festival (春節初二)
  "2025-01-31"  # Spring Festival (春節初三)
  "2025-02-28"  # Peace Memorial Day (和平紀念日)
  "2025-04-04"  # Children's Day & Tomb Sweeping Day (兒童節/清明節)
  "2025-04-05"  # Tomb Sweeping Day adjustment (清明節調整放假)
  "2025-06-02"  # Dragon Boat Festival (端午節)
  "2025-09-03"  # Mid-Autumn Festival compensatory day (中秋節調整放假)
  "2025-10-06"  # Mid-Autumn Festival (中秋節)
  "2025-10-10"  # National Day (國慶日)
  "2025-12-25"  # Constitution Day (行憲紀念日)
)

# ---- Taiwan National Holidays for 2026 ----
HOLIDAYS_2026=(
  "2026-01-01"  # New Year's Day (元旦)
  "2026-02-16"  # Spring Festival Eve (除夕)
  "2026-02-17"  # Spring Festival Day 1 (春節初一)
  "2026-02-18"  # Spring Festival Day 2 (春節初二)
  "2026-02-19"  # Spring Festival Day 3 (春節初三)
  "2026-02-20"  # Spring Festival Day 4 (春節初四)
  "2026-02-27"  # Peace Memorial Day compensatory (和平紀念日補假)
  "2026-02-28"  # Peace Memorial Day (和平紀念日)
  "2026-04-03"  # Children's Day & Tomb Sweeping Day (兒童節/清明節)
  "2026-04-04"  # Tomb Sweeping Day (清明節)
  "2026-04-06"  # Tomb Sweeping Day compensatory (清明節補假)
  "2026-05-01"  # Labor Day (勞動節)
  "2026-06-19"  # Dragon Boat Festival (端午節)
  "2026-09-25"  # Mid-Autumn Festival (中秋節)
  "2026-09-28"  # Teachers' Day / Confucius Birthday (教師節/孔子誕辰)
  "2026-10-09"  # National Day compensatory (國慶日補假)
  "2026-10-10"  # National Day (國慶日)
  "2026-10-25"  # Taiwan Retrocession Day (台灣光復節)
  "2026-10-26"  # Taiwan Retrocession Day compensatory (光復節補假)
  "2026-12-25"  # Constitution Day (行憲紀念日)
)

# Select the appropriate holiday list based on the year
if [ "$YEAR" = "2025" ]; then
  HOLIDAYS=("${HOLIDAYS_2025[@]}")
elif [ "$YEAR" = "2026" ]; then
  HOLIDAYS=("${HOLIDAYS_2026[@]}")
else
  # If year is not defined, only check 2025 for now
  HOLIDAYS=("${HOLIDAYS_2025[@]}")
fi

# ---- Check if today is a national holiday ----
for HOLIDAY in "${HOLIDAYS[@]}"; do
  if [ "$TODAY" = "$HOLIDAY" ]; then
    echo "$(date) | 🟡 National holiday detected ($TODAY), skipping attendance"
    exit 1
  fi
done

# ---- Working day ----
echo "$(date) | 🟢 Working day confirmed ($TODAY)"
exit 0
